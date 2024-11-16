resource "aws_subnet" "private-subnet" {
  count             = length(var.private_cidr_block)
  vpc_id            = aws_vpc.vpc-terra.id
  cidr_block        = element(var.private_cidr_block, count.index + 1)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "${var.vpc_name}-private-subnet-${count.index + 1}"
  }
}

