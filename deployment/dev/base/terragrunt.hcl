include "backend" {
  path   = find_in_parent_folders("backend.hcl")
  expose = true
}

include "root" {
  path   = find_in_parent_folders("terragrunt.hcl")
  expose = true
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
  source = "../../../modules//base"
}

locals {
  workspace_name = include.environment.inputs.prefix
}

inputs = {
  cidr_block             = "10.3.0.0/16"
  workspace_name         = local.workspace_name
  workspace_metastore_id = dependency.metastore.outputs.databricks_metastore_id
}

dependency "metastore" {
  config_path = "../../metastore"
}

dependencies {
  paths = ["../../metastore"]
}

generate "db_provider" {
  path      = "databricks_provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "databricks" {
  host          = "https://accounts.cloud.databricks.com"
  account_id    = "${include.backend.locals.databricks_account_id}"
}
EOF
}
