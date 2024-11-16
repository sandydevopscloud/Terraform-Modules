resource "aws_route_table" "public-rt-terra" {
  vpc_id = aws_vpc.vpc-terra.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-terra.id
  }

  tags = {
    Name = "${var.vpc_name}-public-route-table"
  }
}

resource "aws_route_table" "private-rt-terra" {
  vpc_id = aws_vpc.vpc-terra.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.natgw_id
  }

  tags = {
    Name = "${var.vpc_name}-private-route-table"
  }
}

resource "aws_route_table_association" "public-rta-terra" {
  count          = length(var.public_cidr_block)
  subnet_id      = element(aws_subnet.public-subnet.*.id, count.index + 1)
  route_table_id = aws_route_table.public-rt-terra.id
}

resource "aws_route_table_association" "private-rta-terra" {
  count          = length(var.private_cidr_block)
  subnet_id      = element(aws_subnet.private-subnet.*.id, count.index + 1)
  route_table_id = aws_route_table.private-rt-terra.id
}

