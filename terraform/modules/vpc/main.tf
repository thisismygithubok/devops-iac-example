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

# Route Table - Public Subnets
resource "aws_route_table_association" "public_subnets" {
    count = length(var.public_subnet_cidrs)
    subnet_id = aws_subnet.public_subnets[count.index].id
    route_table_id = aws_route_table.rt_devops_challenge.id
}

##### Below for internet access needed in private subnets for instances to download & deploy ansible playbooks #####

# Elastic IPs for NAT Gateways
resource "aws_eip" "nat_eip" {
    count = length(var.public_subnet_cidrs)
    domain = "vpc"
}

# NAT Gateways - Public Subnets - WebServer Internet Access for ansible etc.
resource "aws_nat_gateway" "nat_gw" {
    count = length(var.public_subnet_cidrs)
    allocation_id = aws_eip.nat_eip[count.index].id
    subnet_id = aws_subnet.public_subnets[count.index].id
}

# NAT GWs - Route Tables
resource "aws_route_table" "rt_private_subnets" {
    count = length(var.private_subnet_cidrs)
    vpc_id = aws_vpc.devops_challenge.id

    tags = {
        Name = "${var.env_name}-private-rt"
    }
}

# NAT GWs - Allow traffic out to internet
resource "aws_route" "private_nat_gw_route" {
    count = length(var.private_subnet_cidrs)
    route_table_id = aws_route_table.rt_private_subnets[count.index].id
    nat_gateway_id = aws_nat_gateway.nat_gw[count.index].id
    destination_cidr_block = "0.0.0.0/0"
}

# Route Table - Private Subnets
resource "aws_route_table_association" "private_subnets" {
    count = length(var.private_subnet_cidrs)
    subnet_id = aws_subnet.private_subnets[count.index].id
    route_table_id = aws_route_table.rt_private_subnets[count.index].id
}