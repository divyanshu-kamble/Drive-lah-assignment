resource "aws_iam_policy" "s3_policy" {
  name        = var.name
  description = var.description
  policy = var.policy
}
