###########################################################
# Root main.tf
###########################################################

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }

  backend "s3" {
    # Fill with your backend config
    bucket         = "demo-githubactions-terraform-state"
    key            = "network/vpc/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}

provider "aws" {
  region = var.aws_region
}

###########################################################
# Calling VPC Module
###########################################################

module "vpc_advanced" {
  source = "./modules/vpc-advanced"

  app_name = var.app_name

  # If empty → creates a new VPC
  # If set → attaches resources to an existing VPC
  vpc_id   = var.vpc_id
  vpc_cidr = var.vpc_cidr

  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  create_igw = var.create_igw

  # Conditional features
  require_peering = var.require_peering
  require_transit = var.require_transit

  # Peering inputs
  peer_vpc_id       = var.peer_vpc_id
  peer_vpc_account  = var.peer_vpc_account
  peer_region       = var.peer_region

  tags = var.tags
}

###########################################################
# Outputs
###########################################################

output "vpc_id" {
  value = module.vpc_advanced.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc_advanced.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc_advanced.private_subnet_ids
}

output "tgw_id" {
  value = module.vpc_advanced.transit_gateway_id
}


output "vpc_peering_connection_id" {
  value = module.vpc_advanced.vpc_peering_connection_id
}
