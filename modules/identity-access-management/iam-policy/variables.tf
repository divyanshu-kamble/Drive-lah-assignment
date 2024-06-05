variable "name" {
  description = "Name of iam-policy"
  type        = string
}
variable "description" {
  description = "description of the iam-policy"
  type        = string
  default     = null
}
variable "tags" {
  description = "tags for the iam-policy"
  type = map(string)
  default = {
    type = "iam-policy"
  }
}
 
variable "policy" {
  description = "policy"
  type = string
}
