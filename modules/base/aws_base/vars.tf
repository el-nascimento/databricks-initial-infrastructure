# variable "databricks_account_username" {}
# variable "databricks_account_password" {}
variable "databricks_account_id" {
  type = string
}


variable "tags" {
  default = {}
  type = map(string)
}

variable "cidr_block" {
  # default = "10.4.0.0/16"
  type = string
}

variable "region" {
  type = string
}

variable "prefix" {
  type = string
  description = "Resource prefix"
}

locals {
  prefix = var.prefix
}

