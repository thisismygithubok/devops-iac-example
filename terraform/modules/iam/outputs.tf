output "iam_instance_profile_ec2_cloudwatch_name" {
    description = "IAM Instance Profile Name for EC2 CloudWatch"
    value = aws_iam_instance_profile.ec2_cloudwatch.name
}