include "backend" {
  path   = find_in_parent_folders("backend.hcl")
  expose = true
}

include "vars" {
  path   = find_in_parent_folders("vars.hcl")
  expose = true
}

include "region" {
  path   = find_in_parent_folders("region.hcl")
  expose = true
}

terraform {
  source = "../../modules//databricks_account"
}

inputs = {
  account_level_groups = [
    "DataEngineers",
    "Administrators"
  ]
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
