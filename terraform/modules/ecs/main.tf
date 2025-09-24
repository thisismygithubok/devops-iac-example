### ECS Clusters and Services ###

# ECS Cluster - Webserver
resource "aws_ecs_cluster" "frontend" {
    name = "${var.product_name}-${var.env_name}-frontend"

    setting {
        name = "containerInsights"
        value = "enabled"
    }
}

# ECS Service - Webserver
resource "aws_ecs_service" "webserver" {
    name = "webserver"
    cluster = aws_ecs_cluster.frontend.id
    task_definition = aws_ecs_task_definition.webserver.arn
    desired_count = 3
    launch_type = "FARGATE"

    network_configuration {
        subnets = var.private_subnet_ids
        security_groups = [var.ec2_sg, var.db_sg_id]
        assign_public_ip = false
    }

    load_balancer {
        target_group_arn = var.ecs_webserver_tg_arn
        container_name = "webserver"
        container_port = "80"
    }

    depends_on = [aws_ecs_task_definition.webserver]
}

# ECS Task Definition - Webserver
resource "aws_ecs_task_definition" "webserver" {
    family = "${var.product_name}-${var.env_name}-webserver-td"
    requires_compatibilities = ["FARGATE"]
    network_mode = "awsvpc"
    cpu = 1024
    memory = 2048
    execution_role_arn = var.iam_role_ecs_task_execution_arn

    container_definitions = <<TASK_DEFINITION
[
    {
        "name": "webserver",
        "image": "${var.webserver_ecr_repo_url}:${var.release_version}",
        "cpu": 1024,
        "memory": 2048,
        "essential": true,
        "environment": [
            {"name": "DATABASE_CONNECTION_STRING", "value": "${var.webserver_db_connectionstring}"}
        ],
        "portMappings": [
            {
                "containerPort": 80,
                "hostPort": 80,
                "protocol": "tcp"
            }
        ]
    }
]
TASK_DEFINITION
}