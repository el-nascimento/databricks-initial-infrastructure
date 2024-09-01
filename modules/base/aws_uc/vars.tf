variable "databricks_account_id" {
  type = string
}

# variable "databricks_workspace_url" {
#   type = string
# }

variable "workspaces_to_associate" {
  description = <<EOT
  (Optional) List of Databricks workspace IDs to be enabled with Unity Catalog.
  Enter with square brackets and double quotes
  e.g. ["111111111", "222222222"]
  EOT
  type        = list(string)
  default     = []
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

locals {
  prefix = "${var.organization}-${var.project}-${var.region}-demo"
}
