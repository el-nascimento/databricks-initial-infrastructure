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
  prefix = "${include.vars.locals.organization}-${include.vars.locals.project}-${include.region.locals.region}-${include.environment.locals.environment}"
}

inputs = {
  prefix = local.prefix
  cluster_config = {
    cluster_name            = "${local.prefix}-single-node-sandbox-cluster"
    data_security_mode      = "SINGLE_USER"
    single_user_name        = "lucas.nascimento@qubika.com"
    runtime_engine          = "STANDARD"
    autotermination_minutes = 10
    num_workers             = 0
  }
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
