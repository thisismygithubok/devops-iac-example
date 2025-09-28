### AWS Secrets Manager Secrets ###

# Import Random String Gen
resource "random_uuid" "unique_identifier" {
    # keepers = {...} - need to find some kind of catch here to monitor to know when to rotate these credentials
}

# DB Credentials
resource "aws_secretsmanager_secret" "db_credentials" {
    name = "${var.env_name}-database-credentials-${random_uuid.unique_identifier.result}"
    description = "DB credentials for the RDS MariaDB instance"
}

# DB Credential Versions
resource "aws_secretsmanager_secret_version" "db_credentials" {
    secret_id = aws_secretsmanager_secret.db_credentials.id
    secret_string = jsonencode({
        username = var.db_username
        password = var.db_password
    })
}