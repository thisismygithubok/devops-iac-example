### IAM Resources ###

# IAM Role - EC2 CloudWatch Logging
resource "aws_iam_role" "ec2_cloudwatch" {
    name = "${var.env_name}-ec2-cloudwatch"
    assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}

# IAM policy - EC2 CW role
data "aws_iam_policy_document" "ec2_assume_role" {
    statement {
        effect = "Allow"
        principals {
            type        = "Service"
            identifiers = ["ec2.amazonaws.com"]
        }
        actions = ["sts:AssumeRole"]
    }
}

# IAM Policy Attachment - CW agent
resource "aws_iam_role_policy_attachment" "cloudwatch_agent" {
    role = aws_iam_role.ec2_cloudwatch.name
    policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# IAM Instance Profile - EC2 CW
resource "aws_iam_instance_profile" "ec2_cloudwatch" {
    name = "${var.env_name}-ec2-cloudwatch"
    role = aws_iam_role.ec2_cloudwatch.name
}

# IAM Role - ECS Task Execution Role
resource "aws_iam_role" "ecs_task_execution" {
    name = "${var.product_name}-${var.env_name}-ecs-role"
    assume_role_policy = data.aws_iam_policy_document.ecs_assume_role.json
}

# IAM policy - ECS Task Execution Role
data "aws_iam_policy_document" "ecs_assume_role" {
    statement {
        effect = "Allow"
        principals {
            type        = "Service"
            identifiers = ["ecs-tasks.amazonaws.com"]
        }
        actions = ["sts:AssumeRole"]
    }
}

# IAM Policy Attachment - ECS Task Execution Role
resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
    role = aws_iam_role.ecs_task_execution.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}