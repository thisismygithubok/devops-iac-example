variable "product_name" {
    type = string
    description = "Product Name"
}

variable "env_name" {
    type = string
    description = "Environment Name"
}

variable "release_version" {
    type = string
    description = "Release version being deployed"
}

variable "db_sg_id" {
    type = string
    description = "DB SG"
}

variable "ec2_sg" {
    type = string
    description = "SG for the EC2 instances"
}

variable "private_subnet_ids" {
    type = list(string)
    description = "Private subnet IDs for the DB subnet group"
}

variable "ecs_webserver_tg_arn" {
    type = string
    description = "ARN of the ECS WebServer TG"
}

variable "webserver_ecr_repo_url" {
    type = string
    description = "WebServer ECR Repo URL"
}

variable "webserver_db_connectionstring" {
    type = string
    description = "WebServer DB Connection String"
}

variable "iam_role_ecs_task_execution_arn" {
    type = string
    description = "IAM Role ARN for the ECS Task Execution Role"
}