include "root" {
  path = find_in_parent_folders("terragrunt.hcl")
}

terraform {
  source = "../../../modules//base"
}

inputs = {
  cidr_block = "10.0.2.0/16"
}
