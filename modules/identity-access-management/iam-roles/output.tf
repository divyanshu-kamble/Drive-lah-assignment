output "iam-role-arn" {
  description = "arn of the iam-role"
  value       =  aws_iam_role.aws_iam_role.arn
}
output "iam-role-name" {
  description = "name of the iam-role"
  value       =  aws_iam_role.aws_iam_role.name
}
output "iam-role-tags" {
  description = "tags associated with the iam-role"
  value       =  aws_iam_role.aws_iam_role.tags_all
}
output "iam-role-unique-id" {
  description = "unique id of iam-role"
  value       =  aws_iam_role.aws_iam_role.unique_id
}

