###############################################
# VPC Module 
###############################################

locals {
  app_name = var.app_name

  # Determine final VPC ID
  vpc_id = var.vpc_id != "" ? var.vpc_id : aws_vpc.this[0].id

  tags = merge(
    var.tags,
    {
      AppName = local.app_name
    }
  )
}

###############################################
# CREATE VPC ONLY IF vpc_id IS NOT PROVIDED
###############################################

resource "aws_vpc" "this" {
  count               = var.vpc_id == "" ? 1 : 0
  cidr_block          = var.vpc_cidr
  enable_dns_support  = true
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge(local.tags, {
    Name = "${local.app_name}-vpc"
  })
}

###############################################
# SUBNETS (support existing/new VPC)
###############################################

resource "aws_subnet" "public" {
  count             = length(var.public_subnets)
  vpc_id            = local.vpc_id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = element(var.azs, count.index)

  map_public_ip_on_launch = true

  tags = merge(local.tags, {
    Name = "${local.app_name}-public-${count.index}"
  })
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id            = local.vpc_id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = element(var.azs, count.index)

  tags = merge(local.tags, {
    Name = "${local.app_name}-private-${count.index}"
  })
}

###############################################
# INTERNET GATEWAY (optional)
###############################################

resource "aws_internet_gateway" "igw" {
  count  = var.create_igw ? 1 : 0
  vpc_id = local.vpc_id

  tags = merge(local.tags, {
    Name = "${local.app_name}-igw"
  })
}

###############################################
# PUBLIC ROUTE TABLE
###############################################

resource "aws_route_table" "public" {
  count  = var.create_igw ? 1 : 0
  vpc_id = local.vpc_id

  tags = merge(local.tags, {
    Name = "${local.app_name}-public-rt"
  })
}

resource "aws_route" "public_internet" {
  count                  = var.create_igw ? 1 : 0
  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw[0].id
}

resource "aws_route_table_association" "public_assoc" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public[0].id
}

###############################################
# TRANSIT GATEWAY (conditional)
###############################################

resource "aws_ec2_transit_gateway" "tgw" {
  count = var.require_transit ? 1 : 0

  description = "${local.app_name} transit gateway"

  tags = merge(local.tags, {
    Name = "${local.app_name}-tgw"
  })
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_attach" {
  count = var.require_transit ? 1 : 0

  subnet_ids         = aws_subnet.private[*].id
  transit_gateway_id = aws_ec2_transit_gateway.tgw[0].id
  vpc_id             = local.vpc_id

  tags = merge(local.tags, {
    Name = "${local.app_name}-tgw-attach"
  })
}

###############################################
# VPC PEERING (conditional)
###############################################

resource "aws_vpc_peering_connection" "peer" {
  count = var.require_peering ? 1 : 0

  vpc_id        = local.vpc_id
  peer_vpc_id   = var.peer_vpc_id
  peer_region   = var.peer_region
  peer_owner_id = var.peer_vpc_account

  tags = merge(local.tags, {
    Name = "${local.app_name}-peering"
  })
}

resource "aws_vpc_peering_connection_accepter" "peer_accept" {
  count = var.require_peering ? 1 : 0

  vpc_peering_connection_id = aws_vpc_peering_connection.peer[0].id
  auto_accept               = true

  tags = merge(local.tags, {
    Name = "${local.app_name}-peering-accept"
  })
}
