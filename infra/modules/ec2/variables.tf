variable "name" {
  description = "Base name tag for the instance"
  type        = string
}

variable "ami_id" {
  description = "AMI ID to launch"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "Subnet to place the instance in (optional)"
  type        = string
  default     = null
}

variable "vpc_security_group_ids" {
  description = "List of SGs to attach (optional)"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Additional resource tags"
  type        = map(string)
  default     = {}
}
