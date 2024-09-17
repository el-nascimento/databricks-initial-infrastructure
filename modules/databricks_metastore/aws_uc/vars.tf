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

data "databricks_group" "engineers" {
  display_name = "DataEngineers"
}

data "databricks_group" "administrators" {
  display_name = "Administrators"
}

