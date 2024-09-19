data "databricks_group" "data_engineers" {
  display_name = "DataEngineers"
}

data "databricks_group" "administrators" {
  display_name = "Administrators"
}

resource "databricks_mws_permission_assignment" "data_engineers" {
  workspace_id = databricks_mws_workspaces.this.workspace_id
  principal_id = data.databricks_group.data_engineers.id
  permissions  = ["USER"]
  depends_on   = [databricks_metastore_assignment.this]
}

resource "databricks_mws_permission_assignment" "administrators" {
  workspace_id = databricks_mws_workspaces.this.workspace_id
  principal_id = data.databricks_group.administrators.id
  permissions  = ["ADMIN"]
  depends_on   = [databricks_metastore_assignment.this]
}
