variable "cidr_block" {
  type        = string
  description = "The address space for the Databricks vpc"
  # default = "10.0.2.0/24"
}

variable "region" {
  type        = string
  description = "The region for deployment"
}

variable "databricks_account_id" {
  type = string
}

variable "workspace_name" {
  type = string
}

variable "prefix" {
  type = string
}

variable "workspace_metastore_id" {
  description = "ID of the metastore to be used for the workspace"
  type = string
}
