
resource "databricks_grants" "data_engineers" {
  metastore = databricks_metastore.this.metastore_id
  grant {
    principal  = data.databricks_group.engineers.display_name
    privileges = ["CREATE_CATALOG", "CREATE_EXTERNAL_LOCATION"]
  }
  depends_on = [databricks_metastore_assignment.default_metastore, databricks_metastore.this]
}

resource "databricks_grants" "administrators" {
  metastore = databricks_metastore.this.metastore_id
  grant {
    principal = data.databricks_group.administrators.display_name
    privileges = [
      "CREATE_CATALOG",
      "CREATE_CONNECTION",
      "CREATE_EXTERNAL_LOCATION",
      "CREATE_PROVIDER",
      "CREATE_RECIPIENT",
      "CREATE_SHARE",
      "CREATE_STORAGE_CREDENTIAL",
      "MANAGE_ALLOWLIST",
    ]
  }
  depends_on = [databricks_grants.data_engineers]
}
