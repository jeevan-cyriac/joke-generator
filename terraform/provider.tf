
provider "aws" {
  profile = "training"
  region  = "us-east-1"
  default_tags {
    tags = local.default_tags
  }
}

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0"
    }
  }
  backend "s3" {
    key     = "prod/joke-generator/terraform.tfstate"
    bucket  = "jeevan-personal-training-terraform-statefiles"
    region  = "us-east-1"
    profile = "training"
  }
}

