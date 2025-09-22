variable "env_name" {
  description = "Environment Name"
  type = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type = string
}

variable "availability_zones" {
  description = "AZs to create subnets in"
  type = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDRs for public subnets"
  type = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDRs for private subnets"
  type = list(string)
}
