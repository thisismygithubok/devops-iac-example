variable "env_name" {
    type = string
    description = "Environment Name"
}

variable "db_username" {
    type = string
    description = "WebServer DB Username"
    sensitive = true
}

variable "db_password" {
    type = string
    description = "WebServer DB Password"
    sensitive = true
}