# S3 Bucket Configuration
bucket_name = "my-lambda-function-bucket-2024"
acl         = "private"
s3_tags = {
  Project     = "my-project-lambda"
}

# IAM Role Configuration
lambda_iam_role_name = "my-lambda-role"

# IAM Policy Configuration
lambda_iam_policy_name = "my-lambda-policy"

# Lambda Function Configuration
lambda_function_name = "s3-lambda-test"
handler              = "lambda-function.lambda_handler"
runtime              = "python3.12"
architectures        = ["arm64"]

# SQS Queue Configuration
sqs_tags = {
  Project     = "my-project-lambda"
}

dlq_sqs_name = "my-dlq-queue"
sqs_name = "my-sqs-queue"
visibility_timeout_seconds = 10
message_retention_seconds  = 60 
delay_seconds              = 1
max_message_size           = 262144 # 256 KB
receive_wait_time_seconds  = 5
dlq_message_retention_seconds = 3600

