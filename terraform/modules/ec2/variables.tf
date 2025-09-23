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

variable "create_asg_service_linked_role" {
    description = "Whether or not to create the AWS ASG service-linked role (only needed on fresh account deployment)"
    type = bool
    default = true
}

variable "iam_instance_profile_ec2_cw" {
    description = "IAM Instance Profile Name for the EC2 CW Role"
    type = string
}