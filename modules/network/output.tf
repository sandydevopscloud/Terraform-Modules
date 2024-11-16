output "vpc_name" {
  value = var.vpc_name
}

output "vpc_id" {
  value = aws_vpc.vpc-terra.id
}

output "environment" {
  value = var.environment
}


output "public_subnets_id" {
  value = aws_subnet.public-subnet.*.id
}

output "private_subnets_id" {
  value = aws_subnet.private-subnet.*.id
}
