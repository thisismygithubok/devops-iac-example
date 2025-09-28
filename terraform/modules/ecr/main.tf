### ECR Repos and Associated Resources ###

# ECR Repo
resource "aws_ecr_repository" "webserver" {
    name = "${var.product_name}-webserver"
    image_tag_mutability = "MUTABLE_WITH_EXCLUSION"

    image_scanning_configuration {
        scan_on_push = true
    }

    # Don't allow images tagged starting w/ release to be retagged
    image_tag_mutability_exclusion_filter {
        filter = "release*"
        filter_type = "WILDCARD"
    }
}

# ECR Repo - Lifecycle Policy
resource "aws_ecr_lifecycle_policy" "webserver" {
    repository = aws_ecr_repository.webserver.name

    policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Cleanup untagged images older than 30 days",
            "selection": {
                "tagStatus": "untagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 30
            },
            "action": {
                "type": "expire"
            }
        },
        {
            "rulePriority": 2,
            "description": "Cleanup dev/feature/bugfix images older than 60 days",
            "selection": {
                "tagStatus": "tagged",
                "tagPrefixList": ["dev", "feature", "bugfix"],
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 60
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}

# WebServer Image Build & Push
resource "null_resource" "webserver_docker_build_and_push" {
    triggers = {
        # rebuild if repo url changes
        repository_url = aws_ecr_repository.webserver.repository_url

        # fetch hash of docker folder contents to see if rebuild is needed
        docker_contents_hash = sha256(join("", [for f in fileset("${path.module}/../../../docker", "**") : filesha256("${path.module}/../../../docker/${f}")]))
    }

    provisioner "local-exec" {
        command = <<EOT
            aws ecr get-login-password --region ${var.deploy_region} --profile ${var.aws_cli_profile} | docker login --username AWS --password-stdin ${aws_ecr_repository.webserver.repository_url}
            docker build --platform linux/amd64 -t webserver:latest -f ${path.module}/../../../docker/dockerfile ${path.module}/../../../docker
            docker tag webserver:latest ${aws_ecr_repository.webserver.repository_url}:latest
            docker push ${aws_ecr_repository.webserver.repository_url}:latest
        EOT
    }
}