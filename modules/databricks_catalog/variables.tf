
variable "name" {
  type = string
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

locals {
  prefix = var.prefix
  catalog_bucket = "${local.prefix}-${var.name}-catalog"
}
