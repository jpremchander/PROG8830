# VPC Module (modules/vpc/main.tf)
resource "aws_vpc" "new_vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.new_vpc.id
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.new_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_subnet" "public_subnet_1a" {
  vpc_id                  = aws_vpc.new_vpc.id
  cidr_block              = var.subnet_cidr_1a
  availability_zone       = "ca-central-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_subnet_1b" {
  vpc_id                  = aws_vpc.new_vpc.id
  cidr_block              = var.subnet_cidr_1b
  availability_zone       = "ca-central-1b"
  map_public_ip_on_launch = true
}

resource "aws_route_table_association" "public_subnet_1a" {
  subnet_id      = aws_subnet.public_subnet_1a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_subnet_1b" {
  subnet_id      = aws_subnet.public_subnet_1b.id
  route_table_id = aws_route_table.public_rt.id
}