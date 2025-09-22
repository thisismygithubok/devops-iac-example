# AWS provider
provider "aws" {
    region = var.deploy_region
    default_tags {
      tags = {
        Environment = var.env_name
        Owner = var.env_owner
        Product = var.product_name
      }
    }
}

# TLS Provider - Used for self-signed cert generation
provider "tls" {}