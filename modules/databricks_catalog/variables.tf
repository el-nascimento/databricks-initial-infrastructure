
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

locals {
  prefix          = var.prefix
  catalog_bucket  = "${local.prefix}-catalog"
  catalog_storage = "s3://${module.bucket.s3_bucket_id}/"
  raw_bucket      = "${local.prefix}-raw"
  sandbox_bucket  = "${local.prefix}-sandbox"
  unity_catalog_role_arn = "arn:aws:iam::414351767826:role/unity-catalog-prod-UCMasterRole-14S5ZJVKOTYTL"
}
