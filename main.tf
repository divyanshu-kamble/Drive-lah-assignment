module "s3_bucket" {
  source      = "./modules/storage/s3/"
  bucket_name = var.bucket_name
  versioning  = true
  tags        = var.s3_tags
}

#IAM role for lambda
module "lambda_iam_role" {
  source = "./modules/identity-access-management/iam-roles/"
  name   = var.lambda_iam_role_name
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
})
}

#IAM policy for lambda
module "lambda_iam_policy" {
  source = "./modules/identity-access-management/iam-policy/"
  name   = var.lambda_iam_policy_name
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "logs:CreateLogGroup",
        Resource = "arn:aws:logs:us-east-1:339712957414:*"
      },
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = [
          "arn:aws:logs:us-east-1:339712957414:log-group:/aws/lambda/${module.lambda_function.lambda_function_name}:*"
        ]
      },
      {
        Effect   = "Allow",
        Action   = "s3:GetObject",
        Resource = "${module.s3_bucket.bucket_arn}/*"
      },
      {
        Effect   = "Allow",
        Action   = "sqs:SendMessage",
        Resource = module.sqs_queue.queue_arn
      }
    ]
  })
  depends_on = [module.s3_bucket, module.sqs_queue]
}

#IAM role and policy attachment
module "lambda_iam_role_policy_attachment" {
  source     = "./modules/identity-access-management/iam-role-policy-attachment/"
  role       = module.lambda_iam_role.iam-role-name
  policy_arn = module.lambda_iam_policy.iam-policy-arn
}

#Main Lambda Function
module "lambda_function" {
  source        = "./modules/lambda/"
  iam_role     = module.lambda_iam_role.iam-role-arn
  function_name = var.lambda_function_name
  handler       = var.handler
  runtime       = var.runtime
  architectures = var.architectures
  filename      = "./my_lambda_function.zip"
  environment_variables = {
    SQS_QUEUE_URL = module.sqs_queue.queue_url
  }
  depends_on = [module.dlq, module.sqs_queue, module.s3_bucket]
}

module "dlq" {
  source = "./modules/sqs/"

  name                       = var.dlq_sqs_name
  visibility_timeout_seconds = var.visibility_timeout_seconds
  message_retention_seconds  = var.dlq_message_retention_seconds
  delay_seconds              = var.delay_seconds
  max_message_size           = var.max_message_size
  receive_wait_time_seconds  = var.receive_wait_time_seconds
}

module "sqs_queue" {
  source                     = "./modules/sqs/"
  name                       = var.sqs_name
  visibility_timeout_seconds = var.visibility_timeout_seconds
  message_retention_seconds  = var.message_retention_seconds
  delay_seconds              = var.delay_seconds
  max_message_size           = var.max_message_size
  receive_wait_time_seconds  = var.receive_wait_time_seconds

  tags = var.sqs_tags

  redrive_policy = jsonencode({
    deadLetterTargetArn = module.dlq.queue_arn,
    maxReceiveCount     = 1
  })
}

resource "aws_sqs_queue_redrive_allow_policy" "main_sqs_queue_redrive" {
#The Url of the queue to which to attach this policy 
  queue_url = module.sqs_queue.queue_url

  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = [module.dlq.queue_arn]
  })
}

#Create a s3 bucket trigger for lambda based on the object condition and the object suffix
resource "aws_s3_bucket_notification" "aws-lambda-trigger" {
  bucket = module.s3_bucket.bucket_id
  lambda_function {
    lambda_function_arn = module.lambda_function.lambda_function_arn
    events              = ["s3:ObjectCreated:*"]
    filter_suffix       = ".json"
  }
  depends_on = [ module.lambda_function ]
}

#Gives permission to s3 to invoke lambda function
resource "aws_lambda_permission" "test" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_function.lambda_function_name
  principal     = "s3.amazonaws.com"
  source_arn    = module.s3_bucket.bucket_arn
}

#Destination for events after they have been processed from lambda
resource "aws_lambda_function_event_invoke_config" "lambda_sqs" {
  function_name = module.lambda_function.lambda_function_name
  destination_config {
    on_success {
      destination = module.sqs_queue.queue_arn
    }
  }
}
