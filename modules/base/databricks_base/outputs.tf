output "databricks_host_name" {
  value       = databricks_mws_workspaces.this.workspace_name
  description = "Workspace Name"
}

output "databricks_host" {
  value = databricks_mws_workspaces.this.workspace_url
  description = "URL for newly created Databricks workspace"
}

output "databricks_host_id" {
  value       = databricks_mws_workspaces.this.workspace_id
  description = "Workspace numeric ID"
}

output "databricks_token" {
  value = databricks_mws_workspaces.this.token[0].token_value
  sensitive = true
  description = "Databricks workspace management token"
}
