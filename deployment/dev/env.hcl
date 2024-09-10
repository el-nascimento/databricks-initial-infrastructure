locals {
  project_vars   = read_terragrunt_config(find_in_parent_folders("vars.hcl"))
  aws_account_id = "008971679247"
  environment    = "dev"
  organization   = local.project_vars.locals.organization
  project        = local.project_vars.locals.project

  workspace_host = "${local.project_vars.locals.organization}-"
}

inputs = {
  environment    = local.environment
  aws_account_id = local.aws_account_id
  workspace_host = local.workspace_host
}
