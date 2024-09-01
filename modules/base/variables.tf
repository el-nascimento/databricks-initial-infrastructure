variable "cidr_block" {
  type = string
  description = "The address space for the Databricks vpc"
  # default = "10.0.2.0/24"
}

variable "tags" {
  type = map(string)
  description = "Tags for the resources"
  default = {}
}

variable "region" {
  type = string
  description = "The region for deployment"
}

variable "databricks_account_id" {
  type = string
}

variable "relay_vpce_service" {
  type = string
}

variable "workspace_vpce_service" {
  type = string
}

# variable "databricks_account_username" {
#   type = string
# }

# variable "databricks_account_password" {
#   type = string
# }

variable "allow_ip_list" {
  type = list(string)
}

variable "use_ip_access_list" {
  type = bool
}

variable "project" {
  type = string
}

variable "organization" {
  type = string
}
