# Variables for S3 Bucket
variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "acl" {
  description = "The ACL for the S3 bucket"
  type        = string
  default     = "private"
}

variable "s3_tags" {
  description = "Tags for the S3 bucket"
  type        = map(string)
  default     = {}
}

# Variables for IAM Role
variable "lambda_iam_role_name" {
  description = "The name of the IAM role for the Lambda function"
  type        = string
}

# Variables for IAM Policy
variable "lambda_iam_policy_name" {
  description = "The name of the IAM policy for the Lambda function"
  type        = string
}

# Variables for Lambda Function
variable "lambda_function_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "handler" {
  description = "The handler for the Lambda function"
  type        = string
}

variable "runtime" {
  description = "The runtime for the Lambda function"
  type        = string
}

variable "architectures" {
  description = "The underlying architecture"
  type        = list(string)
}

# Variables for SQS Queue
variable "sqs_tags" {
  description = "Tags for the SQS queue"
  type        = map(string)
  default     = {}
}

variable "sqs_name" {
  description = "The name of the SQS dead letter queue"
  type        = string
}

variable "dlq_sqs_name" {
  description = "The name of the SQS dead letter queue"
  type        = string
}

variable "visibility_timeout_seconds" {
  description = "The visibility timeout for the SQS dead letter queue in seconds"
  type        = number
}

variable "message_retention_seconds" {
  description = "The number of seconds Amazon SQS retains a message"
  type        = number
}

variable "dlq_message_retention_seconds" {
  description = "The number of seconds Amazon SQS retains a message"
  type        = number
}

variable "delay_seconds" {
  description = "The time in seconds that the delivery of all messages in the queue will be delayed"
  type        = number
}

variable "max_message_size" {
  description = "The limit of how many bytes a message can contain before Amazon SQS rejects it"
  type        = number
}

variable "receive_wait_time_seconds" {
  description = "The time for which a ReceiveMessage call will wait for a message to arrive"
  type        = number
}

