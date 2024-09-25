module "bucket" {
  source        = "terraform-aws-modules/s3-bucket/aws"
  version       = "4.1.2"
  bucket        = local.catalog_bucket
  force_destroy = true
  versioning = {
    enabled = false
  }
}

data "databricks_aws_unity_catalog_assume_role_policy" "catalog" {
  aws_account_id = data.aws_caller_identity.current.account_id
  role_name      = local.catalog_access_role_name
  external_id    = databricks_storage_credential.catalog.aws_iam_role[0].external_id
}

data "databricks_aws_unity_catalog_policy" "catalog" {
  aws_account_id = data.aws_caller_identity.current.account_id
  bucket_name    = module.bucket.s3_bucket_id
  role_name      = local.catalog_access_role_name
}

resource "aws_iam_policy" "catalog" {
  policy = data.databricks_aws_unity_catalog_policy.catalog.json
}


resource "aws_iam_role" "catalog_data_access" {
  name                = local.catalog_access_role_name
  assume_role_policy  = data.databricks_aws_unity_catalog_assume_role_policy.catalog.json
  managed_policy_arns = [aws_iam_policy.catalog.arn]
}
