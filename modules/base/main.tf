module "aws_base" {
  source                = "./aws_base/"
  cidr_block            = var.cidr_block
  tags                  = var.tags
  region                = var.region
  databricks_account_id = var.databricks_account_id
  prefix                = var.prefix
}

module "databricks_base" {
  source                   = "./databricks_base/"
  workspace_name           = var.workspace_name
  prefix                   = var.prefix
  region                   = var.region
  databricks_account_id    = var.databricks_account_id
  cross_account_role_arn   = module.aws_base.cross_account_role_arn
  root_storage_bucket_name = module.aws_base.root_bucket
  vpc_id                   = module.aws_base.vpc_id
  security_group_ids       = module.aws_base.security_group
  subnets                  = module.aws_base.subnets
}

# module "aws_fs_lakehouse" {
#   source                 = "./aws_fs_lakehouse/"
#   project                = var.project
#   organization           = var.organization
#   region                 = var.region
#   workspace_url          = module.aws_base.databricks_host
#   crossaccount_role_name = split("/", module.aws_base.cross_account_role_arn)[1]
#   allow_ip_list          = var.allow_ip_list
#   use_ip_access_list     = var.use_ip_access_list
#   prefix = var.prefix
#   # databricks_account_username = var.databricks_account_username
#   # databricks_account_password = var.databricks_account_password
#   providers = {
#     databricks = databricks.workspace
#   }
#   depends_on = [module.aws_uc]
# }
