resource "aws_eip" "eip1" {
  domain     = "vpc"

  tags = {
    Name = "fahim-eip1"
  }
}

resource "aws_nat_gateway" "ng1" {
  allocation_id = aws_eip.eip1.id
  subnet_id = aws_subnet.public-subnet1.id

  tags = {
    Name = "fahim-nat-gateway-1"
  }
}


resource "aws_eip" "eip2" {
  domain     = "vpc"

  tags = {
    Name = "fahim-eip2"
  }
}

resource "aws_nat_gateway" "ng2" {
  allocation_id = aws_eip.eip2.id
  subnet_id = aws_subnet.public-subnet2.id

  tags = {
    Name = "fahim-nat-gateway-2"
  }
}


resource "aws_route_table" "rtb-private-1" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ng1.id
  }
}

resource "aws_route_table_association" "rta-private-1a" {
  subnet_id = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.rtb-private-1.id
}

resource "aws_route_table_association" "rta-private-1b" {
  subnet_id = aws_subnet.private_subnet3.id
  route_table_id = aws_route_table.rtb-private-1.id
}


resource "aws_route_table" "rtb-private-2" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ng2.id
  }
}

resource "aws_route_table_association" "rta-private-2a" {
  subnet_id = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.rtb-private-2.id
}

resource "aws_route_table_association" "rta-private-2b" {
  subnet_id = aws_subnet.private_subnet4.id
  route_table_id = aws_route_table.rtb-private-2.id
}