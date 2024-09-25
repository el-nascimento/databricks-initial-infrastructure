// Raw bucket volume
module "raw_bucket" {
  source        = "terraform-aws-modules/s3-bucket/aws"
  version       = "4.1.2"
  bucket        = local.raw_bucket
  force_destroy = true
  versioning = {
    enabled = false
  }
}

data "databricks_aws_unity_catalog_assume_role_policy" "external_raw_bucket" {
  aws_account_id = data.aws_caller_identity.current.account_id
  role_name      = local.raw_bucket_access_role_name
  external_id    = databricks_storage_credential.raw_data.aws_iam_role[0].external_id
}

data "databricks_aws_unity_catalog_policy" "external_raw_bucket" {
  aws_account_id = data.aws_caller_identity.current.account_id
  bucket_name    = module.raw_bucket.s3_bucket_id
  role_name      = local.raw_bucket_access_role_name
}

resource "aws_iam_policy" "external_raw_bucket" {
  policy = data.databricks_aws_unity_catalog_policy.external_raw_bucket.json
}


resource "aws_iam_role" "raw_data_access" {
  name                = local.raw_bucket_access_role_name
  assume_role_policy  = data.databricks_aws_unity_catalog_assume_role_policy.external_raw_bucket.json
  managed_policy_arns = [aws_iam_policy.external_raw_bucket.arn]
}

// Sandbox bucket volume
module "sandbox_bucket" {
  source        = "terraform-aws-modules/s3-bucket/aws"
  version       = "4.1.2"
  bucket        = local.sandbox_bucket
  force_destroy = true
  versioning = {
    enabled = false
  }
}

data "databricks_aws_unity_catalog_assume_role_policy" "external_sandbox_bucket" {
  aws_account_id = data.aws_caller_identity.current.account_id
  role_name      = local.sandbox_bucket_access_role_name
  external_id    = databricks_storage_credential.sandbox_data.aws_iam_role[0].external_id
}

data "databricks_aws_unity_catalog_policy" "external_sandbox_bucket" {
  aws_account_id = data.aws_caller_identity.current.account_id
  bucket_name    = module.sandbox_bucket.s3_bucket_id
  role_name      = local.sandbox_bucket_access_role_name
}

resource "aws_iam_policy" "external_sandbox_bucket" {
  policy = data.databricks_aws_unity_catalog_policy.external_sandbox_bucket.json
}

resource "aws_iam_role" "sandbox_data_access" {
  name                = local.sandbox_bucket_access_role_name
  assume_role_policy  = data.databricks_aws_unity_catalog_assume_role_policy.external_sandbox_bucket.json
  managed_policy_arns = [aws_iam_policy.external_sandbox_bucket.arn]
}
