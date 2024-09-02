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

variable "project" {
  type = string
}

variable "organization" {
  type = string
}

variable "prefix" {
  type = string
  description = "Resource prefix"
}

variable "workspace_name" {
  type = string
  description = "Name for workspace"
}

locals {
  prefix = var.prefix
}

