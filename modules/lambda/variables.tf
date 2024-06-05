variable "iam_role" {
  description = "Policy statements for the IAM role"
  type        = string
}

variable "function_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "handler" {
  description = "The function entrypoint in your code"
  type        = string
  default     = null
}

variable "runtime" {
  description = "The runtime environment for the Lambda function"
  type        = string
}

variable "filename" {
  description = "The path to the deployment package file"
  type        = string
}

variable "architectures" {
  description = "The underlying architecture"
  type        = list(string)
}

variable "environment_variables" {
  description = "A map of environment variables to assign to the Lambda function"
  type        = map(string)
  default     = {}
}

