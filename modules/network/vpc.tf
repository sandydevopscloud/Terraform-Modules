
resource "aws_vpc" "vpc-terra" {
  cidr_block           = var.vpc_cidr_block # "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"

  tags = {
    Name        = var.vpc_name #"vpc-terra"
    owner       = "PROD"
    costcenter  = "Hyd-8"
    environment = var.environment
  }
}

