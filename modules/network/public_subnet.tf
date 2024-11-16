resource "aws_subnet" "public-subnet" {
  count             = length(var.public_cidr_block)
  vpc_id            = aws_vpc.vpc-terra.id
  cidr_block        = element(var.public_cidr_block, count.index + 1)
  availability_zone = element(var.azs, count.index)
  tags = {
    Name = "${var.vpc_name}-public-subnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "igw-terra" {
  vpc_id = aws_vpc.vpc-terra.id

  tags = {
    Name = "${var.vpc_name}-IGW"
  }
}

