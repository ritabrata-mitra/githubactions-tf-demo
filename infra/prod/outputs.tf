output "prod_instance_id" { value = module.prod_linux_ec2.instance_id }
output "prod_public_ip"   { value = module.prod_linux_ec2.public_ip }
output "prod_private_ip"  { value = module.prod_linux_ec2.private_ip }
output "prod_ami"         { value = module.prod_linux_ec2.ami }
