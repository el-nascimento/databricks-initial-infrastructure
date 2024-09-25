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
  source = "../../../modules//databricks_catalog"
}

locals {
  catalog_name = "${include.environment.inputs.environment}_db"
}

inputs = {
  name               = local.catalog_name
  metastore_id       = dependency.metastore.outputs.databricks_metastore_id
  databricks_host_id = dependency.base.outputs.databricks_host_id
}

dependency "base" {
  config_path = "../base"
}

dependency "metastore" {
  config_path = "../../metastore"

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
