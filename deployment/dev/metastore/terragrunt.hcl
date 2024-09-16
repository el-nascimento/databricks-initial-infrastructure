include "root" {
  path = find_in_parent_folders("terragrunt.hcl")
}

include "vars" {
  path   = find_in_parent_folders("vars.hcl")
  expose = true
}

include "environment" {
  path   = find_in_parent_folders("env.hcl")
  expose = true
}

include "region" {
  path   = find_in_parent_folders("region.hcl")
  expose = true
}

terraform {
  source = "../../../modules//catalog"
}

locals {
  prefix         = "${include.vars.locals.organization}-${include.vars.locals.project}-${include.region.locals.region}"
  workspace_name = local.prefix
}

inputs = {
  prefix                  = local.prefix
  workspaces_to_associate = [dependency.base.outputs.databricks_host_id]
}

dependency "base" {
  config_path = "../base"
}

generate "db_provider" {
  path      = "databricks_provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "databricks" {
  alias         = "workspace"
  account_id    = "${include.root.locals.databricks_account_id}"
}
EOF
}
