resource "aws_vpc" "arch-vpc" {
  cidr_block = var.cidr-block
  tags = {
    Name = "${var.vpc-name}-vpc"
  }
}

# SUBNETS

resource "aws_subnet" "arch-pub-sub-1" {
  vpc_id     = aws_vpc.arch-vpc.id
  cidr_block = cidrsubnet(var.cidr-block, 8, 1)
  availability_zone = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc-name}-pub-sub-1"
  }
}
resource "aws_subnet" "arch-pub-sub-2" {
  vpc_id     = aws_vpc.arch-vpc.id
  cidr_block = cidrsubnet(var.cidr-block, 8, 2)
  availability_zone = "${var.region}b"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc-name}-pub-sub-2"
  }
}


# SECURITY GROUP

resource "aws_security_group" "arch-sg" {
  name        = "arch-sg"
  description = "Allow ALL inbound traffic"
  vpc_id      = aws_vpc.arch-vpc.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.vpc-name}-sg"
  }
}

# Internet Gateway

resource "aws_internet_gateway" "arch-igw" {
  vpc_id = aws_vpc.arch-vpc.id

  tags = {
    Name = "${var.vpc-name}-igw"
  }
}

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.arch-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.arch-igw.id
  }

  tags = {
    Name = "${var.vpc-name}-MRT"
  }
}

resource "aws_route_table_association" "public_route_association-1" {
  subnet_id      = aws_subnet.arch-pub-sub-1.id
  route_table_id = aws_route_table.public_route.id
}
resource "aws_route_table_association" "public_route_association-2" {
  subnet_id      = aws_subnet.arch-pub-sub-2.id
  route_table_id = aws_route_table.public_route.id
}