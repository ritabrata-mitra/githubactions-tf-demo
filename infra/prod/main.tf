data "aws_ami" "amzn_linux" {
  most_recent = true
  owners      = ["137112412989"] # Amazon Linux AMI owner (us-east-1)
  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "state"
    values = ["available"]
  }
}

module "prod_linux_ec2" {
  source = "../modules/ec2"

  name           = var.instance_name
  ami_id         = data.aws_ami.amzn_linux.id
  instance_type  = var.instance_type
  subnet_id      = null
  vpc_security_group_ids = []

  tags = {
    Environment = "prod"
    OS          = "linux"
  }
}
