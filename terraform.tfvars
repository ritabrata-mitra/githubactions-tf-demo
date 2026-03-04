###########################################################
# terraform.tfvars for VPC Advanced Module
###########################################################

# AWS region used by provider
aws_region = "us-east-1"

# Application / project name
app_name = "myapp"

###########################################################
# VPC Selection
###########################################################

# Leave empty ("") to create new VPC 
# OR supply an existing VPC ID (default VPC or custom)
vpc_id = ""

# Used only if creating a new VPC
vpc_cidr = "10.50.0.0/16"

###########################################################
# AZs and Subnets
###########################################################

azs = [
  "us-east-1a",
  "us-east-1b"
]

public_subnets = [
  "10.50.1.0/24",
  "10.50.2.0/24"
]

private_subnets = [
  "10.50.11.0/24",
  "10.50.12.0/24"
]

###########################################################
# Optional Infrastructure
###########################################################

create_igw = true

# Transit Gateway (creates TGW + attachment if true)
require_transit = false

# VPC Peering (creates requester+accepter if true)
require_peering = false

# Optional Peering Inputs
peer_vpc_id      = ""
peer_vpc_account = ""
peer_region      = ""

###########################################################
# Tags
###########################################################

tags = {
  Environment = "dev"
  Owner       = "Terraform"
}
