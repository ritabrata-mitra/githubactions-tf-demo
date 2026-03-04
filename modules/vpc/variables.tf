###############################################
# BASIC SETTINGS
###############################################

variable "app_name" {
  type        = string
  description = "Application name or VPC prefix"
}

variable "vpc_id" {
  type        = string
  default     = ""
  description = "If provided, use this existing VPC instead of creating a new one"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR for new VPC (ignored if vpc_id is provided)"
  default     = "10.0.0.0/16"
}

variable "enable_dns_hostnames" {
  type    = bool
  default = true
}

###############################################
# SUBNETS & AZs
###############################################

variable "azs" {
  type        = list(string)
  description = "List of AZs for subnet creation"
}

variable "public_subnets" {
  type        = list(string)
  default     = []
}

variable "private_subnets" {
  type        = list(string)
  default     = []
}

###############################################
# CONDITIONAL RESOURCES
###############################################

variable "create_igw" {
  type    = bool
  default = true
}

variable "require_peering" {
  type    = bool
  default = false
}

variable "require_transit" {
  type    = bool
  default = false
}

###############################################
# PEERING INPUTS
###############################################

variable "peer_vpc_id" {
  type    = string
  default = ""
}

variable "peer_vpc_account" {
  type    = string
  default = ""
}

variable "peer_region" {
  type    = string
  default = ""
}

###############################################
# TAGS
###############################################

variable "tags" {
  type        = map(string)
  default     = {}
}
