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
  source = "../../../modules//lakehouse"
}

locals {
  prefix = "${include.vars.locals.organization}-${include.vars.locals.project}-${include.region.locals.region}-${include.environment.locals.environment}"
}

inputs = {
  allow_ip_list = [
    "191.13.238.152"
  ]
  prefix             = local.prefix
  use_ip_access_list = false
  job_cluster_id     = dependency.cluster.outputs.cluster_id
}

dependency "base" {
  config_path = "../base"
}

dependency "cluster" {
  config_path = "../single-node-cluster"
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
