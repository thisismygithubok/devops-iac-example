### Database Resources ###

# AWS RDS MariaDB for WebServers
resource "aws_db_instance" "webserver_db" {
    identifier = "${var.env_name}-webserver-db"
    instance_class = "db.t4g.micro"
    engine = "mariadb"
    engine_version = "11.8.3"
    allocated_storage = 20
    max_allocated_storage = 50
    db_name = "webserver"
    username = jsondecode(var.db_webserver_credentials).username
    password = jsondecode(var.db_webserver_credentials).password
    vpc_security_group_ids = [var.db_sg_id]
    db_subnet_group_name = aws_db_subnet_group.webserver_db.name
    skip_final_snapshot = false
    final_snapshot_identifier = "${var.env_name}-webserver-db-snapshot-FINAL"
    multi_az = true
}

# WebServer DB Subnet Group - Private Subnets
resource "aws_db_subnet_group" "webserver_db" {
    name = "${var.env_name}-db-subnet-group"
    subnet_ids = var.private_subnet_ids
}