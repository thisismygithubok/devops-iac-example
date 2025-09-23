variable "domain_name" {
    type = string
    description = "R53 Domain Name"
}

variable "env_name" {
    type = string
    description = "Environment Name"
}

variable "env_owner" {
    type = string
    description = "Environment Owner Name"
}

variable "product_name" {
    type = string
    description = "Product Name"
}

variable "deploy_region" {
    type = string
    description = "Deployment Region"
    default = "us-east-1"
}

variable "availability_zones" {
    type = list
    description = "AZs for resources"
    default = ["us-east-1a","us-east-1b","us-east-1c"]
}

variable "db_username" {
    type = string
    description = "Webserver DB Username"
    sensitive = true
}

variable "db_password" {
    type = string
    description = "Webserver DB Password"
    sensitive = true
}