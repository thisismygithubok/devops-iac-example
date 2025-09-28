terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.14"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.1"
    }

    random = {
      source = "hashicorp/random"
      version = "~> 3.7.2"
    }
  }

  required_version = ">= 1.13"
}