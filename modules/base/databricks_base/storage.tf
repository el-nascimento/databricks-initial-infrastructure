resource "aws_s3_bucket_policy" "root_bucket_policy" {
  bucket     = var.root_storage_bucket_name
  policy     = data.databricks_aws_bucket_policy.this.json
}

data "databricks_aws_bucket_policy" "this" {
  bucket = var.root_storage_bucket_name
}

resource "databricks_mws_storage_configurations" "this" {
  account_id                 = var.databricks_account_id
  bucket_name                = var.root_storage_bucket_name
  storage_configuration_name = "${local.prefix}-storage-configuration"
}
