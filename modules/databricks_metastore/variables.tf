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

variable "databricks_host_id" {
  type        = string
}

variable "project" {
  type = string
}

variable "organization" {
  type = string
}

variable "prefix" {
  type = string
}
