output "webserver_ecr_repo_url" {
    description = "WebServer ECR Repo URL"
    value = aws_ecr_repository.webserver.repository_url
}