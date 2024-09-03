variable "databricks_account_id" {
  type = string
}

variable "root_storage_bucket_name" {
  type = string
}

variable "prefix" {
  type = string
}

variable "workspace_name" {
  type = string
  description = "Name for workspace"
}

variable "region" {
  type = string
}

variable "cross_account_role_arn" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "subnets" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

locals {
  prefix = var.prefix
}

