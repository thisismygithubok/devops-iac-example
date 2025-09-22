variable "env_name" {
    type = string
    description = "Environment Name"
}

variable "vpc_id" {
    type = string
    description = "VPC ID for the environment"
}

variable "alb_sg" {
    type = string
    description = "SG attached to the public ALB"
}

variable "public_subnets" {
    type = list(string)
    description = "List of public subnets for the ALB"
}

variable "certificate_arn" {
    type = string
    description = "ARN of the self signed cert for the HTTPS listener"
}

variable "ssl_policy" {
    type = string
    description = "SSL policy for the HTTPS listener"
    default = "ELBSecurityPolicy-TLS13-1-2-2021-06"
}