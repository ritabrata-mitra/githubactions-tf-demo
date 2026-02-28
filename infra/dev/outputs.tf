output "dev_instance_id" { value = module.dev_windows_ec2.instance_id }
output "dev_public_ip"   { value = module.dev_windows_ec2.public_ip }
output "dev_private_ip"  { value = module.dev_windows_ec2.private_ip }
output "dev_ami"         { value = module.dev_windows_ec2.ami }
