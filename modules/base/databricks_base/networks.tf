resource "databricks_mws_networks" "this" {
  account_id         = var.databricks_account_id
  network_name       = "${local.prefix}-network"
  security_group_ids = var.security_group_ids
  subnet_ids         = var.subnets
  vpc_id             = var.vpc_id
}
