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
  region  = "us-east-1"

}
resource "aws_instance" "my_instance" {
  ami           = "ami-0015bce43071c5586"
  instance_type = "t3.micro"
  tags = {
    Name = "my-ec2-instance"
  }
}
