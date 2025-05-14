terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.50.0"
    }
  }


backend "s3" {
    bucket = "dev140525"
    key = "dev/terraform.tfstate"
    region = "us-east-2"
}
}

provider "aws" {
  region = var.region
}
