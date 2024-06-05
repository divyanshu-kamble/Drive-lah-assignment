variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "versioning" {
  description = "Enable versioning on the bucket"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to assign to the bucket"
  type        = map(string)
  default     = {}
}

variable "bucket_policy" {
  description = "The bucket policy to attach to the bucket"
  type        = string
  default     = ""
}
