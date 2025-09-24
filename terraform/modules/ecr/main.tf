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

