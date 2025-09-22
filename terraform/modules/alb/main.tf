### ALB and Associated Resources ###

# ALB
resource "aws_lb" "public_lb" {
    name = "${var.env_name}-ALB-Public"
    internal = false
    load_balancer_type = "application"
    security_groups = [var.alb_sg]
    subnets = var.public_subnets
}

# ALB - Target Group
resource "aws_lb_target_group" "webserver_tg" {
    name = "${var.env_name}-WebServer-TG"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id

    health_check {
        enabled = true
        healthy_threshold = 2
        unhealthy_threshold = 2
        interval = 30
        timeout = 5
        path = "/healthcheck"
        matcher = "200"
        protocol = "HTTP"
    }
}

# ALB - Listener - HTTP Redirect
resource "aws_lb_listener" "http_redirect" {
    load_balancer_arn = aws_lb.public_lb.arn
    port = "80"
    protocol = "HTTP"

    default_action {
        type = "redirect"

        redirect {
            port = "443"
            protocol = "HTTPS"
            status_code = "HTTP_301"
        }
    }
}

# ALB - Listener - HTTPS Forward
resource "aws_lb_listener" "https_forward" {
    load_balancer_arn = aws_lb.public_lb.arn
    port = "443"
    protocol = "HTTPS"
    ssl_policy = var.ssl_policy
    certificate_arn = var.certificate_arn

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.webserver_tg.arn
    }
}