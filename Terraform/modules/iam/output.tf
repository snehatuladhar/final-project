output "ssm_instance_profile_arn" {
  description = "The ARN of the SSM instance profile"
  value       = aws_iam_instance_profile.ssm_instance_profile.arn
}

output "ssm_role_name" {
  description = "The name of the IAM role"
  value       = aws_iam_role.ssm_role.name
}
