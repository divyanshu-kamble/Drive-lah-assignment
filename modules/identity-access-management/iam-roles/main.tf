resource "aws_iam_role" "aws_iam_role" {
  name                  = var.name
  assume_role_policy    = var.assume_role_policy
  managed_policy_arns   = var.managed_policy_arns
  force_detach_policies = var.force_detach_policies
  description           = var.description
  max_session_duration  = var.max_session_duration
  tags                  = var.tags
}
