resource "aws_iam_instance_profile" "iam_profile_terra" {
  name = var.instance_profile_name
  role = aws_iam_role.ec2_role.name
}

