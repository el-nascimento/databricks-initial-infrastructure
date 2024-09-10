locals {
  # Load account and region variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  project_vars     = read_terragrunt_config(find_in_parent_folders("vars.hcl"))

  project      = local.project_vars.locals.project
  organization = local.project_vars.locals.organization

  aws_region     = local.region_vars.locals.region
  aws_account_id = local.environment_vars.locals.aws_account_id
  environment    = local.environment_vars.locals.environment
  workspace_host = local.environment_vars.locals.workspace_host

  databricks_account_id = "8a5add79-c74f-4236-90f1-3f6a1c24d692"
  aws_admin_account_id  = "891376913502"

  aws_admin_iam_role = "arn:aws:iam::${local.aws_admin_account_id}:role/TerraformAdminRole"
  aws_child_iam_role = "arn:aws:iam::${local.aws_account_id}:role/TerraformChildRole"
}

# Generate AWS account specific provider block.
# Do assume_role to AWS Organizations default role
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
    region = "${local.aws_region}"

    assume_role {
        role_arn = "${local.aws_child_iam_role}"
    }

    default_tags {
        tags = {
            account = "${local.aws_account_id}"
            environment = "${local.environment}"
            project = "${local.project}"
            organization = "${local.organization}"
        }
    }
}

provider "random" {}

EOF
}

#Combine all variables
inputs = {
  databricks_account_id = local.databricks_account_id
  aws_admin_account_id  = local.aws_admin_account_id
}

remote_state {
  backend = "s3"
  config = {
    bucket  = "${local.organization}-terraform-tf-state"
    key     = "${local.project}/${path_relative_to_include()}/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}
