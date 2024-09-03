module "aws_uc" {
  source                  = "./aws_uc/"
  project                 = var.project
  organization            = var.organization
  databricks_account_id   = var.databricks_account_id
  region                  = var.region
  workspaces_to_associate = var.workspaces_to_associate
  prefix = var.prefix
  # databricks_account_username = var.databricks_account_username
  # databricks_account_password = var.databricks_account_password
  # providers = {
  #   databricks = databricks.workspace
  # }
}
