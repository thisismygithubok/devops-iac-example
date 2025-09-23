variable "env_name" {
    type = string
    description = "Environment Name"
}

variable "db_webserver_credentials" {
    type = string
    description = "Webserver DB Credentials"
    sensitive = true
}

variable "db_sg_id" {
    type = string
    description = "DB SG"
}

variable "private_subnet_ids" {
    type = list(string)
    description = "Private subnet IDs for the DB subnet group"
}