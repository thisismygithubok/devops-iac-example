variable "hosted_zone_name" {
    type = string
    description = "Domain Name of Hosted Zone"
}

variable "public_alb_dns_name" {
    type = string
    description = "Public ALB DNS Name"
}

variable "public_alb_dns_zone_id" {
    type = string
    description = "Public ALB DNS Zone ID"
}