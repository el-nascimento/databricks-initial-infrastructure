variable "databricks_account_id" {
  type = string
}

variable "databricks_host_id" {
  type = string
}

variable "region" {
  type = string
}

variable "prefix" {
  type        = string
  description = "Resource prefix"
}

locals {
  prefix = var.prefix
}
