### IAM Resources ###

# IAM Role for EC2 CloudWatch Logging
resource "aws_iam_role" "ec2_cloudwatch" {
    name = "${var.env_name}-ec2-cloudwatch"
    assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}

# IAM policy for EC2 CW role
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

# IAM policy for CW agent
resource "aws_iam_role_policy_attachment" "cloudwatch_agent" {
    role = aws_iam_role.ec2_cloudwatch.name
    policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# IAM instance profile for EC2 CW
resource "aws_iam_instance_profile" "ec2_cloudwatch" {
    name = "${var.env_name}-ec2-cloudwatch"
    role = aws_iam_role.ec2_cloudwatch.name
}