resource "aws_lambda_function" "lambda_function" {
  function_name    = var.function_name
  role             = var.iam_role
  handler          = var.handler
  runtime          = var.runtime
  filename         = var.filename
  architectures    = var.architectures
  source_code_hash = filebase64sha256(var.filename)
  environment {
    variables = var.environment_variables
  }
}