variable "instance_name" {
  description = "Tag Name for dev instance"
  type        = string
  default     = "dev-windows-ec2"
}

variable "instance_type" {
  description = "Dev instance type"
  type        = string
  default     = "t3.medium"
}
