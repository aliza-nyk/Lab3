resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_type == "vpc-blue" ? var.blue_cidr : var.green_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = { Name = var.vpc_type == "vpc-blue" ? "VPC-Blue" : "VPC-Green" }
}

resource "aws_internet_gateway" "ipg" {
  vpc_id = aws_vpc.vpc.id
  tags   = { Name = var.vpc_type == "vpc-blue" ? "igw-blue" : "igw-green" }
}

resource "aws_subnet" "subnets" {
  count                   = var.vpc_type == "vpc-blue" ? length(var.blue_cidr_blocks) : length(var.green_cidr_blocks)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.vpc_type == "vpc-blue" ? var.blue_cidr_blocks[count.index] : var.green_cidr_blocks[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true
  tags                    = { Name = var.vpc_type == "vpc-blue" ? "SN-blue-${count.index + 1}" : "SN-green-${count.index + 1}" }
}

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ipg.id
  }
  tags = { Name = var.vpc_type == "vpc-blue" ? "RT-blue" : "RT-green" }
}

resource "aws_route_table_association" "RT" {
  count = length(aws_subnet.subnets)

  subnet_id      = aws_subnet.subnets[count.index].id
  route_table_id = aws_route_table.RT.id
}



output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnets" {
  value = aws_subnet.subnets[*].id
}

