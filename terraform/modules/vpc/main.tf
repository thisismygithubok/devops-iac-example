### VPC and Associated Resources ###

# VPC
resource "aws_vpc" "devops_challenge" {
    cidr_block = var.cidr_block
}

# Private Subnets
resource "aws_subnet" "private_subnets" {
    count = length(var.private_subnet_cidrs)
    vpc_id = aws_vpc.devops_challenge.id
    cidr_block = element(var.private_subnet_cidrs, count.index)
    availability_zone = element(var.availability_zones, count.index)
    tags = {
        Name = "${var.env_name}-private-subnet-${count.index +1}"
    }
}

# Public Subnets
resource "aws_subnet" "public_subnets" {
    count = length(var.public_subnet_cidrs)
    vpc_id = aws_vpc.devops_challenge.id
    cidr_block = element(var.public_subnet_cidrs, count.index)
    availability_zone = element(var.availability_zones, count.index)
    tags = {
        Name = "${var.env_name}-public-subnet-${count.index +1}"
    }
}

# IGW - Public Subnets
resource "aws_internet_gateway" "igw_devops_challenge" {
    vpc_id = aws_vpc.devops_challenge.id
}

# IGW - Route Table
resource "aws_route_table" "rt_devops_challenge" {
    vpc_id = aws_vpc.devops_challenge.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw_devops_challenge.id
    }
    tags = {
        Name = "${var.env_name}-public-rt"
    }
}

# Route Table - Associations
resource "aws_route_table_association" "public_subnets_devops_challenge" {
    count = length(var.public_subnet_cidrs)
    subnet_id = element(aws_subnet.public_subnets[*].id, count.index)
    route_table_id = aws_route_table.rt_devops_challenge.id
}