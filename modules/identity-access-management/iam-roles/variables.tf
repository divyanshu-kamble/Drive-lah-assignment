variable "name" {
  description = "Name of iam-role"
  type        = string
}
variable "managed_policy_arns" {
  description = "ARN of managed policy"
  default     = null
}
variable "assume_role_policy" {
  description = "Role policy in json"
}
variable "force_detach_policies" {
  description = "Whether to force detaching any policies the role has before destroying it"
  type = bool
  default     = false
}
variable "description" {
  description = "description of iam"
  type        = string
  default     = null
}
variable "max_session_duration" {
  description = " Maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours."
  type        = string
  default     = null
}
variable "tags" {
  description = "Tags for the iam role"
  type        = map(string)
  default     = null
}
