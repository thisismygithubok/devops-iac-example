output "webserver_db_endpoint" {
    description = "WebServer DB Endpoint"
    value = aws_db_instance.webserver_db.endpoint
}

output "webserver_db_port" {
    description = "WebServer DB Port"
    value = aws_db_instance.webserver_db.port
}

output "webserver_db_connectionstring" {
    description = "WebServer DB Connection String"
    value = "mysql://${jsondecode(var.db_webserver_credentials).username}:${jsondecode(var.db_webserver_credentials).password}@${aws_db_instance.webserver_db.endpoint}:${aws_db_instance.webserver_db.port}/${aws_db_instance.webserver_db.db_name}"
}