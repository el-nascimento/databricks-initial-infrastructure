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
  source = "../../../modules//lakehouse"
}

inputs = {
  job_cluster_id     = dependency.cluster.outputs.clusters.sandbox.cluster_id
}

dependency "base" {
  config_path = "../base"
}

dependency "cluster" {
  config_path = "../de-clusters"
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
