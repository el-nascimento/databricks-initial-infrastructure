module "aws_uc" {
  source                = "./aws_uc/"
  databricks_account_id = var.databricks_account_id
  region                = var.region
  databricks_host_id    = var.databricks_host_id
  prefix                = var.prefix
}
