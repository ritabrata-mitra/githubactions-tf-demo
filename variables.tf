variable "aws_region" {
  description = "AWS region for the provider"
  type        = string
}

variable "app_name" {
  description = "Application name"
  type        = string
}

variable "vpc_id" {
  description = "Existing VPC ID (leave empty to create a new VPC)"
  type        = string
  default     = ""
}

variable "vpc_cidr" {
  description = "CIDR for new VPC"
  type        = string
}

variable "azs" {
  description = "Availability Zones list"
  type        = list(string)
}

variable "public_subnets" {
  description = "Public Subnet CIDR list"
  type        = list(string)
  default     = []
}

variable "private_subnets" {
  description = "Private Subnet CIDR list"
  type        = list(string)
  default     = []
}

variable "create_igw" {
  description = "Create an Internet Gateway"
  type        = bool
  default     = true
}

variable "require_peering" {
  description = "Enable VPC peering"
  type        = bool
  default     = false
}

variable "require_transit" {
  description = "Enable Transit Gateway"
  type        = bool
  default     = false
}

variable "peer_vpc_id" {
  description = "Peer VPC ID"
  type        = string
  default     = ""
}

variable "peer_vpc_account" {
  description = "Peer AWS Account ID"
  type        = string
  default     = ""
}

variable "peer_region" {
  description = "Peer VPC AWS Region"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}
