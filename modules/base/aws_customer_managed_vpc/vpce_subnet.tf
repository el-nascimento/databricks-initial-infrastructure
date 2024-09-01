// this subnet houses the data plane VPC endpoints
resource "aws_subnet" "dataplane_vpce" {
  vpc_id     = var.vpc_id
  cidr_block = var.vpce_subnet_cidr

  tags = var.tags
}

resource "aws_route_table" "this" {
  vpc_id = var.vpc_id

  tags = var.tags
}

resource "aws_route_table_association" "dataplane_vpce_rtb" {
  subnet_id      = aws_subnet.dataplane_vpce.id
  route_table_id = aws_route_table.this.id
}
