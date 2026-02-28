
data "aws_ami" "windows" {
  most_recent = true
  owners      = ["801119661308"] # Amazon Windows AMI account (us-east-1)
  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Full-Base-*"]
  }
  filter {
    name   = "state"
    values = ["available"]
  }
}

module "dev_windows_ec2" {
  source = "../modules/ec2"

  name           = var.instance_name
  ami_id         = data.aws_ami.windows.id
  instance_type  = var.instance_type
  subnet_id      = null                 # plug your subnet if needed
  vpc_security_group_ids = []           # plug SG IDs if needed

  tags = {
    Environment = "dev"
    OS          = "windows"
  }
}
