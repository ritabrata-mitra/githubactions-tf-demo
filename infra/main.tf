terraform {
  backend "s3" {
    bucket         = "githubactions-tf-demo1234"
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
  ami           = "ami-000b7026f83286c94"
  instance_type = "t3.micro"
  tags = {
    Name = "my-ec2-instance"
  }
}
