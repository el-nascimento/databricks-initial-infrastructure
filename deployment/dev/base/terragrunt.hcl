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
  source = "../../../modules//base"
}

locals {
  prefix         = "${include.vars.locals.organization}-${include.vars.locals.project}-${include.region.locals.region}"
  workspace_name = local.prefix
}

inputs = {
  cidr_block = "10.3.0.0/16"
  allow_ip_list = [
    "104.30.133.4/32"
  ]
  use_ip_access_list = true
  workspace_name     = local.workspace_name
  prefix             = local.prefix
}

generate "db_provider" {
  path      = "databricks_provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "databricks" {
  alias         = "workspace"
  host          = "${local.workspace_name}"
}
EOF
}
