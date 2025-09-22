output "public_alb_dns_name" {
    description = "Public ALB DNS Name"
    value = aws_lb.public_lb.dns_name
}

output "public_alb_dns_zone_id" {
    description = "Public ALB DNS Zone ID"
    value = aws_lb.public_lb.zone_id
}

output "webserver_tg_arn" {
    description = "ARN of the WebServer TG"
    value = aws_lb_target_group.webserver_tg.arn
}