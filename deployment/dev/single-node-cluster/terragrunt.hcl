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
  source = "../../../modules//databricks_cluster"
}

locals {
}

inputs = {
  cluster_config = {
    cluster_name            = "single-node-cluster"
    data_security_mode      = "SINGLE_USER"
    single_user_name        = "lucas.nascimento@qubika.com"
    runtime_engine          = "STANDARD"
    node_type_id            = "m5d.large"
    autotermination_minutes = 30
    num_workers             = 0
  }

  pypi_libraries = [
    "dbl-waterbear",
    "dbl-tempo"
  ]

  maven_libraries = []

}

dependency "base" {
  config_path = "../base"
}

dependencies {
  paths = ["../workspace-config", "../base"]
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
