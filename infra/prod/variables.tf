variable "instance_name" {
  description = "Tag Name for prod instance"
  type        = string
  default     = "prod-linux-ec2"
}

variable "instance_type" {
  description = "Prod instance type"
  type        = string
  default     = "t3.micro"
}
