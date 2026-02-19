terraform {
  backend "s3" {
    bucket         = "githubactions-tf-demo123"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    #dynamodb_table = "terraform-locks-example"
    #encrypt        = true
  }
}
provider "aws" {
  region  = "us-east-1"

}
resource "aws_instance" "my_instance" {
  ami           = "ami-0bb661687d1decf72"
  instance_type = "t3.micro"
  tags = {
    Name = "my-ec2-instance"
  }
}
