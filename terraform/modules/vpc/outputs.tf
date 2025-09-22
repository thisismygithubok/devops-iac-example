output "vpc_id" {
    description = "VPC ID"
    value = aws_vpc.devops_challenge.id
}

output "public_subnet_ids" {
    description = "List of public subnets IDs"
    value = aws_subnet.public_subnets[*].id
}

output "private_subnet_ids" {
    description = "List of private subnets IDs"
    value = aws_subnet.private_subnets[*].id
}

output "igw_id" {
    description = "Internet gateway ID"
    value = aws_internet_gateway.igw_devops_challenge.id
}

output "public_rt_id" {
    description = "Public Route Table ID"
    value = aws_route_table.rt_devops_challenge.id
}