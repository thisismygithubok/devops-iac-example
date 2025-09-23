output "alb_sg_id" {
    description = "Public Facing ALB SG ID"
    value = aws_security_group.alb_sg.id
}

output "webserver_sg_id" {
    description = "Internal WebServer SG ID"
    value = aws_security_group.webserver_sg.id
}

output "db_sg_id" {
    description = "Internal DB SG ID"
    value = aws_security_group.db_sg.id
}