module "aws_base" {
  source                = "./aws_base/"
  cidr_block            = var.cidr_block
  tags                  = var.tags
  region                = var.region
  databricks_account_id = var.databricks_account_id
  project               = var.project
  organization          = var.organization
  # databricks_account_password = var.databricks_account_password
  # databricks_account_username = var.databricks_account_username
}

data "aws_vpc" "prod" {
  id = module.aws_base.vpc_id
}


module "aws_customer_managed_vpc" {
  source                 = "./aws_customer_managed_vpc/"
  project                = var.project
  cidr_block             = var.cidr_block
  tags                   = var.tags
  organization           = var.organization
  region                 = var.region
  relay_vpce_service     = var.relay_vpce_service
  workspace_vpce_service = var.workspace_vpce_service
  vpce_subnet_cidr       = cidrsubnet(data.aws_vpc.prod.cidr_block, 3, 3)
  vpc_id                 = module.aws_base.vpc_id
  subnet_ids             = module.aws_base.subnets
  security_group_id      = module.aws_base.security_group[0]
  cross_account_arn      = module.aws_base.cross_account_role_arn
  databricks_account_id  = var.databricks_account_id
  # databricks_account_username = var.databricks_account_username
  # databricks_account_password = var.databricks_account_password
  providers = {
    databricks = databricks.mws
  }
  depends_on = [module.aws_base]
}


module "aws_uc" {
  source                  = "./aws_uc/"
  project                 = var.project
  organization            = var.organization
  databricks_account_id   = var.databricks_account_id
  region                  = var.region
  workspaces_to_associate = [split("/", module.aws_customer_managed_vpc.workspace_id)[1]]
  # databricks_account_username = var.databricks_account_username
  # databricks_account_password = var.databricks_account_password
  providers = {
    databricks = databricks.workspace
  }
}


module "aws_fs_lakehouse" {
  source                 = "./aws_fs_lakehouse/"
  project                = var.project
  organization           = var.organization
  region                 = var.region
  workspace_url          = module.aws_customer_managed_vpc.workspace_url
  crossaccount_role_name = split("/", module.aws_base.cross_account_role_arn)[1]
  allow_ip_list          = var.allow_ip_list
  use_ip_access_list     = var.use_ip_access_list
  # databricks_account_username = var.databricks_account_username
  # databricks_account_password = var.databricks_account_password

  providers = {
    databricks = databricks.workspace
  }

  depends_on = [module.aws_uc]
}
