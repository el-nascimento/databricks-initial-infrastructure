
variable "name" {
  type        = string
  description = "Name of the catalog"
}

variable "prefix" {
  type = string
}

variable "databricks_account_id" {
  type = string
}

variable "databricks_host_id" {
  type = string
}

variable "metastore_id" {
  type = string
}

data "databricks_group" "engineers" {
  display_name = "DataEngineers"
}

data "databricks_group" "administrators" {
  display_name = "Administrators"
}

data "aws_caller_identity" "current" {}

locals {
  prefix                          = var.prefix
  catalog_bucket                  = "${local.prefix}-catalog"
  catalog_storage                 = "s3://${module.bucket.s3_bucket_id}/"
  catalog_access_role_name        = "${local.catalog_bucket}-access"
  catalog_access_role_arn         = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${local.catalog_access_role_name}"
  raw_bucket_access_role_name     = "${module.raw_bucket.s3_bucket_id}-access"
  raw_bucket_access_role_arn      = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${local.raw_bucket_access_role_name}"
  sandbox_bucket_access_role_name = "${module.sandbox_bucket.s3_bucket_id}-access"
  sandbox_bucket_access_role_arn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${local.sandbox_bucket_access_role_name}"
  raw_bucket                      = "${local.prefix}-raw"
  sandbox_bucket                  = "${local.prefix}-sandbox"
  unity_catalog_role_arn          = "arn:aws:iam::414351767826:role/unity-catalog-prod-UCMasterRole-14S5ZJVKOTYTL"
}
