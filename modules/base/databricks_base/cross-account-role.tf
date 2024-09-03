resource "databricks_mws_credentials" "this" {
  role_arn = var.cross_account_role_arn
  credentials_name = "${local.prefix}-creds"
}
