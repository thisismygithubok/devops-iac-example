### Security Groups ###

# ALB SG - Public Facing
resource "aws_security_group" "alb_sg" {
    name = "${var.env_name}-ALB-SG"
    description = "Allow Internet HTTP/S traffic to/from ALB"
    vpc_id = var.vpc_id

    ingress {
        description = "Allow HTTP from anywhere"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
        protocol = "tcp"
        from_port = 80
        to_port = 80
    }

    ingress {
        description = "Allow HTTPS from anywhere"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
        protocol = "tcp"
        from_port = 443
        to_port = 443
    }

    egress {
        description = "Allow all traffic out"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
        protocol = "-1"
        from_port = 0
        to_port = 0
    }
}

# EC2 WebServer SG - Internal Only
resource "aws_security_group" "webserver_sg" {
    name = "${var.env_name}-WebServer-SG"
    description = "Allow traffic between ALB SG and WebServers"
    vpc_id = var.vpc_id

    ingress {
        description = "Allow HTTP from ALB SG Only"
        security_groups = [aws_security_group.alb_sg]
        protocol = "tcp"
        from_port = 80
        to_port = 80
    }

    egress {
        description = "Allow all traffic out"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
        protocol = "-1"
        from_port = 0
        to_port = 0
    }
}