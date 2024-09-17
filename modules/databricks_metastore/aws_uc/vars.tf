variable "databricks_account_id" {
  type = string
}

variable "databricks_host_id" {
  type        = string
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

variable "tags" {
  type = map(string)
  default = { }
}

variable "prefix" {
  type = string
  description = "Resource prefix"
}

locals {
  prefix = "${var.prefix}-demo"
}
