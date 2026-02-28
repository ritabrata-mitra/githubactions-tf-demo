resource "aws_instance" "this" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.vpc_security_group_ids
  associate_public_ip_address = true

  # Basic root volume defaults; override later as needed
  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }

  tags = merge(
    {
      Name = var.name
    },
    var.tags
  )
}
