output "vpc_id" {
  value = local.vpc_id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "transit_gateway_id" {
  value = var.require_transit ? aws_ec2_transit_gateway.tgw[0].id : null
}

output "vpc_peering_connection_id" {
  value = var.require_peering ? aws_vpc_peering_connection.peer[0].id : null
}
