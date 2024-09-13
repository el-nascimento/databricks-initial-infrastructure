variable "databricks_account_id" {
  type = string
}

variable "catalog_name" {
  type = string
}

variable "prefix" {
  type = string
}

variable "region" {
  type = string
}

locals {
  prefix = var.prefix
}

