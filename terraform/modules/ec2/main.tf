### EC2 Resources ###

# Grab latest AWS Linux 2023 AMI for Launch Template - Kernel 6.1 for stability #
data "aws_ami" "amazon_linux_2023" {
    most_recent = true
    owners = [ "amazon" ]

    filter {
        name = "name"
        values = [ "al2023-ami-2023.*-kernel-6.1-*" ]
    }
    
    filter {
        name = "architecture"
        values = [ "x86_64" ]
    }
}

# Instance Launch Template #
resource "aws_launch_template" "webserver_launch_template" {
    name = "${var.env_name}-launch-template"
    image_id = data.aws_ami.amazon_linux_2023.id
    instance_type = var.webserver_ec2_instance_type

    iam_instance_profile {
        name = var.iam_instance_profile_ec2_cw
    }
    
    network_interfaces {
        security_groups = [var.ec2_sg]
    }

    # deploy ansible playbook for webserver & page
    user_data = filebase64("${path.module}/scripts/install.sh")
}

# Service linked role for ASG
resource "aws_iam_service_linked_role" "asg_service_role" {
    aws_service_name = "autoscaling.amazonaws.com"
    count = var.create_asg_service_linked_role ? 1 : 0
}

# Auto Scaling Group
resource "aws_autoscaling_group" "webserver_asg" {    
    name = "${var.env_name}-webserver-asg"
    vpc_zone_identifier = var.private_subnet_ids
    target_group_arns = [var.webserver_tg_arn]
    desired_capacity = 3
    min_size = 3
    max_size = 12

    health_check_type = "ELB"
    health_check_grace_period = 120 # 2 mins

    availability_zone_distribution {
        capacity_distribution_strategy = "balanced-best-effort"
    }

    launch_template {
        id = aws_launch_template.webserver_launch_template.id
        version = aws_launch_template.webserver_launch_template.latest_version
    }

    instance_refresh {
        strategy = "Rolling"
        preferences {
            auto_rollback = true
            min_healthy_percentage = 50
        }
    }
}