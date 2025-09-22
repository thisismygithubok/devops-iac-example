variable "webserver_ec2_instance_type" {
    type = string
    description = "Instance type for webservers"
}

variable "ec2_sg" {
    type = string
    description = "SG for the EC2 instances"
}

variable "env_name" {
    type = string
    description = "Environment Name"
}

variable "private_subnet_ids" {
  description = "AZs used for ASG"
  type = list(string)
}

variable "webserver_tg_arn" {
    description = "ARN of the WebServer TG"
    type = string
}