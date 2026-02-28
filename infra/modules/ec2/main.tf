variable "instance_type" {}
variable "ami_id" {}

resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Owner = "Rito"
  }
}
