locals {
  aws_account_id = "008971679247"
  environment    = "dev"
  region_vars    = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  project_vars   = read_terragrunt_config(find_in_parent_folders("vars.hcl"))
  organization   = local.project_vars.locals.organization
  project        = local.project_vars.locals.project
  region         = local.region_vars.locals.region
  prefix         = "${local.organization}-${local.project}-${local.region}-${local.environment}"
}

inputs = {
  environment    = local.environment
  aws_account_id = local.aws_account_id
  prefix         = local.prefix
}
