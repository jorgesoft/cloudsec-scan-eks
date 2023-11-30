terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

module "eks" {
  source = "./modules/eks"

  vpc_id     = "vpc-00aa06d88f8431bd3"   # Replace with your VPC ID
  subnet_ids = ["subnet-0310d0087d77a6f18", "subnet-01f44e983f97a5106"] # Replace with your subnet IDs
}