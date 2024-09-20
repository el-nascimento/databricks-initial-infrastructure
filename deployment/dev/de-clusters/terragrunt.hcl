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
  source = "../../../modules//databricks_de_clusters"
}

inputs = {
  cluster_configs = {
    sandbox = {
      workers = {
        max = 5
        min = 1
      }
    }
  }
}

dependency "base" {
  config_path = "../base"
}

dependencies {
  paths = ["../workspace-config", "../base", "../catalog"]
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
