locals {
  project_vars     = read_terragrunt_config(find_in_parent_folders("vars.hcl"))

  project      = local.project_vars.locals.project
  organization = local.project_vars.locals.organization

  databricks_account_id = "8a5add79-c74f-4236-90f1-3f6a1c24d692"
  aws_admin_account_id  = "891376913502"
}

#Combine all variables
inputs = {
  databricks_account_id = local.databricks_account_id
  aws_admin_account_id  = local.aws_admin_account_id
}

remote_state {
  backend = "s3"
  config = {
    bucket  = "${local.organization}-terraform-tf-state"
    key     = "${local.project}/${path_relative_to_include()}/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}
