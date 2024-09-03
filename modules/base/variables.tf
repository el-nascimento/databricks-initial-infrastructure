variable "cidr_block" {
  type        = string
  description = "The address space for the Databricks vpc"
  # default = "10.0.2.0/24"
}

variable "tags" {
  type        = map(string)
  description = "Tags for the resources"
  default     = {}
}

variable "region" {
  type        = string
  description = "The region for deployment"
}

variable "databricks_account_id" {
  type = string
}

variable "project" {
  type = string
}

variable "organization" {
  type = string
}

variable "workspace_name" {
  type = string
}

variable "prefix" {
  type = string
}
