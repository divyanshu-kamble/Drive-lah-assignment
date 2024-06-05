output "iam-policy-arn" {
  description = "arn of the iam-policy"
  value       =  aws_iam_policy.s3_policy.arn
}
output "iam-policy-id" {
  description = "policy id of the iam-policy"
  value       =  aws_iam_policy.s3_policy.policy_id 
}
output "tags" {
  description = "tags of the iam-policy"
  value       =  aws_iam_policy.s3_policy.tags_all
}
