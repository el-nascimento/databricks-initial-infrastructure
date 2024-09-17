
variable "name" {
  type = string
  description = "Name of the catalog"
}

variable "metastore_data_bucket" {
  type = string
  description = "S3 bucket for catalog"
}

variable "prefix" {
  type = string
}

variable "databricks_account_id" {
  type = string
}

variable "metastore_id" {
  type = string
}

locals {
  prefix = var.prefix
  catalog_name = "${var.prefix}-${var.name}"
}
