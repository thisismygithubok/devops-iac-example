output "iam_instance_profile_ec2_cloudwatch_name" {
    description = "IAM Instance Profile Name for EC2 CloudWatch"
    value = aws_iam_instance_profile.ec2_cloudwatch.name
}

output "iam_role_ecs_task_execution_arn" {
    description = "IAM Role ARN for the ECS Task Execution Role"
    value = aws_iam_role.ecs_task_execution.arn
}