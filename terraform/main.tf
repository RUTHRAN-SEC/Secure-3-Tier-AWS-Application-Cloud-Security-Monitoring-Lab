terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# NOTE: Modules are stubs to be filled in as the lab is built out.
# Uncomment and complete each module as you progress through the project.

# module "vpc" {
#   source   = "./vpc"
#   vpc_cidr = var.vpc_cidr
# }

# module "security_groups" {
#   source = "./security-groups"
#   vpc_id = module.vpc.vpc_id
# }

# module "ec2" {
#   source            = "./ec2"
#   subnet_id         = module.vpc.public_subnet_id
#   security_group_id = module.security_groups.ec2_sg_id
# }

# module "rds" {
#   source            = "./rds"
#   subnet_id         = module.vpc.private_subnet_id
#   security_group_id = module.security_groups.rds_sg_id
# }

# module "iam" {
#   source = "./iam"
# }

# module "lambda_sns" {
#   source = "./lambda-sns"
# }
