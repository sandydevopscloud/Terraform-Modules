output "iam_role_name" {
  value = aws_iam_role.ec2_role.name
}

output "iam_instance_profile_name" {
  value = aws_iam_instance_profile.iam_profile_terra.name
}

output "role_arn" {
  value = aws_iam_role.ec2_role.arn
}

