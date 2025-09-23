output "db_webserver_credentials" {
    description = "Webserver DB credentials"
    value = aws_secretsmanager_secret_version.db_credentials.secret_string
    sensitive = true
}