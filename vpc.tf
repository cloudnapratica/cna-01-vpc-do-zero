resource "aws_vpc" "this" {
  cidr_block           = var.vpc_configuration.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
}

resource "aws_subnet" "this" {
  for_each = { for subnet in var.vpc_configuration.subnets : subnet.name => subnet }

  availability_zone_id    = local.az_pairs[each.key]
  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value.cidr_block
  map_public_ip_on_launch = each.value.public

  tags = {
    Name = each.key
  }
}

resource "aws_nat_gateway" "this" {
  for_each = toset(local.private_subnets)

  allocation_id = aws_eip.nat_gateway[each.value].id
  subnet_id     = aws_subnet.this[local.subnet_pairs[each.value]].id
}

resource "aws_eip" "nat_gateway" {
  for_each = toset(local.private_subnets)
  vpc      = true

  depends_on = [aws_internet_gateway.this]
}

# Routes

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
}

resource "aws_route" "internet_gateway" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
  for_each       = toset(local.public_subnets)
  subnet_id      = aws_subnet.this[each.value].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  for_each = toset(local.private_subnets)
  vpc_id   = aws_vpc.this.id
}

resource "aws_route" "nat_gateway" {
  for_each = toset(local.private_subnets)

  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.private[each.value].id
  nat_gateway_id         = aws_nat_gateway.this[each.value].id
}

resource "aws_route_table_association" "private" {
  for_each       = toset(local.private_subnets)
  subnet_id      = aws_subnet.this[each.value].id
  route_table_id = aws_route_table.private[each.value].id
}
