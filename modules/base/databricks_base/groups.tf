resource "databricks_group" "data_engineers" {
  display_name = "DataEngineers"
  allow_cluster_create = true
  allow_instance_pool_create = true
}

resource "databricks_group" "administrators" {
  display_name = "Administrators"
  allow_instance_pool_create = true
  allow_cluster_create = true
}

data "databricks_service_principal" "terragrunt" {
  display_name = "terragrunt"
}

resource "databricks_mws_permission_assignment" "add_de_group" {
  workspace_id = databricks_mws_workspaces.this.workspace_id
  principal_id = databricks_group.data_engineers.id
  permissions = ["USER"]
}

resource "databricks_mws_permission_assignment" "add_admin_group" {
  workspace_id = databricks_mws_workspaces.this.workspace_id
  principal_id = databricks_group.administrators.id
  permissions = ["ADMIN"]
}

resource "databricks_mws_permission_assignment" "add_principal" {
  workspace_id = databricks_mws_workspaces.this.workspace_id
  principal_id = data.databricks_service_principal.terragrunt.id
  permissions = ["ADMIN"]
}
