terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "network" {
  source = "./modules/vpc"
}

module "compute" {
  source = "./modules/ec2"
}

module "security" {
  source = "./modules/security"
}
