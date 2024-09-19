
data "databricks_group" "data_engineers" {
  display_name = "DataEngineers"
}

data "databricks_group" "administrators" {
  display_name = "Administrators"
}

resource "databricks_entitlements" "engineers" {
  group_id                   = data.databricks_group.data_engineers.id
  allow_cluster_create       = false
  allow_instance_pool_create = false
  databricks_sql_access      = true
  workspace_access           = true
}

resource "databricks_entitlements" "administrators" {
  group_id                   = data.databricks_group.administrators.id
  allow_cluster_create       = true
  allow_instance_pool_create = true
  databricks_sql_access      = true
  workspace_access           = true
}
