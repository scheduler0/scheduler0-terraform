resource "aws_vpc" "scheduler0_vpc" {
  cidr_block = "10.24.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  assign_generated_ipv6_cidr_block = true

  tags = {
    Name = "scheduler0_vpc"
  }
}

resource "aws_internet_gateway" "scheduler0_vpc_internet_gateway" {
  vpc_id = aws_vpc.scheduler0_vpc.id

  tags = {
    Name = "scheduler0_vpc_internet_gateway"
  }
}

resource "aws_subnet" "scheduler0_vpc_web_tier_public_subnet_a" {
  vpc_id     = aws_vpc.scheduler0_vpc.id
  cidr_block = "10.24.48.0/20"
  availability_zone = var.vpc_public_subnet_availability_zones[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "scheduler0_vpc_web_tier_public_subnet_a"
  }
}

resource "aws_route_table" "scheduler0_vpc_public_route_table_a" {
  vpc_id = aws_vpc.scheduler0_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.scheduler0_vpc_internet_gateway.id
  }

  tags = {
    Name = "scheduler0_vpc_public_route_table_a"
  }
}

resource "aws_route_table_association" "scheduler0_vpc_public_route_table_subnet_association_a" {
  route_table_id = aws_route_table.scheduler0_vpc_public_route_table_a.id
  subnet_id = aws_subnet.scheduler0_vpc_web_tier_public_subnet_a.id
}

resource "aws_subnet" "scheduler0_vpc_web_tier_public_subnet_b" {
  vpc_id     = aws_vpc.scheduler0_vpc.id
  cidr_block = "10.24.112.0/20"
  availability_zone = var.vpc_public_subnet_availability_zones[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "scheduler0_vpc_web_tier_public_subnet_b"
  }
}


resource "aws_route_table" "scheduler0_vpc_public_route_table_b" {
  vpc_id = aws_vpc.scheduler0_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.scheduler0_vpc_internet_gateway.id
  }

  tags = {
    Name = "scheduler0_vpc_public_route_table_b"
  }
}

resource "aws_route_table_association" "scheduler0_vpc_public_route_table_subnet_association_b" {
  route_table_id = aws_route_table.scheduler0_vpc_public_route_table_b.id
  subnet_id = aws_subnet.scheduler0_vpc_web_tier_public_subnet_b.id
}