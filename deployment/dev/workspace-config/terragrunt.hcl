include "backend" {
  path   = find_in_parent_folders("backend.hcl")
  expose = true
}

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
  source = "../../../modules//databricks_workspace"
}

locals {
  prefix = "${include.vars.locals.organization}-${include.vars.locals.project}-${include.region.locals.region}-${include.environment.locals.environment}"
}

inputs = {
  prefix = local.prefix
}

dependency "base" {
  config_path = "../base"
}

generate "db_provider" {
  path      = "databricks_provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "databricks" {
  host          = "${dependency.base.outputs.databricks_host}"
}
EOF
}
