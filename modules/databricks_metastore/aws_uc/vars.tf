variable "region" {
  type = string
}

data "databricks_group" "engineers" {
  display_name = "DataEngineers"
}

data "databricks_group" "administrators" {
  display_name = "Administrators"
}

