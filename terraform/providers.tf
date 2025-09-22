# AWS provider
provider "aws" {
    region = var.deploy_region
    profile = "terraform"
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