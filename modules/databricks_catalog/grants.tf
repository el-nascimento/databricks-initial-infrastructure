resource "databricks_grants" "catalog" {
  catalog = databricks_catalog.catalog.name
  grant {
    principal  = data.databricks_group.engineers.display_name
    privileges = ["CREATE_TABLE", "CREATE_SCHEMA", "USE_CATALOG", "USE_SCHEMA", "SELECT", "MODIFY"]
  }
  grant {
    principal  = data.databricks_group.administrators.display_name
    privileges = ["ALL_PRIVILEGES"]
  }
  depends_on = [databricks_catalog.catalog]
}

