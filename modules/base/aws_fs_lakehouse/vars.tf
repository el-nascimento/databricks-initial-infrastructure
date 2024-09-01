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

locals {
  prefix = "${var.organization}-${var.project}-${var.region}-fs-lakehouse"
  ext_s3_bucket = "${local.prefix}-ext-bucket"
}
