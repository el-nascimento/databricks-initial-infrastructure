module "aws_uc" {
  source                  = "./aws_uc/"
  project                 = var.project
  organization            = var.organization
  databricks_account_id   = var.databricks_account_id
  region                  = var.region
  workspaces_to_associate = var.workspaces_to_associate
  prefix = var.prefix
  providers = {
    databricks = databricks.workspace
  }
}
