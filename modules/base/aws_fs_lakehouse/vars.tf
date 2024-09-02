variable "crossaccount_role_name" {
  type        = string
  description = "Role that you've specified on https://accounts.cloud.databricks.com/#aws"
}

variable "workspace_url" {
  type = string
}

# variable "databricks_account_username" {
#   type = string
# }

# variable "databricks_account_password" {
#   type = string
# }

variable "allow_ip_list" { type = list(string) }

variable "use_ip_access_list" { type = bool }

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

locals {
  prefix = "${var.prefix}-fs-lakehouse"
  ext_s3_bucket = "${local.prefix}-ext-bucket"
}
