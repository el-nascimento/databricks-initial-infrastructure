data "databricks_group" "engineers" {
  display_name = "DataEngineers"
}

variable "prefix" {
  type        = string
  description = "Resource prefix"
}

variable "region" {
  type = string
  description = "AWS Region"
}
