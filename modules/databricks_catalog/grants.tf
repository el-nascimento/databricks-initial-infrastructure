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
  depends_on = [databricks_catalog.catalog, databricks_grants.metastore]
}

resource "databricks_grants" "metastore" {
  metastore = var.metastore_id
  grant {
    principal  = data.databricks_group.engineers.display_name
    privileges = ["CREATE_CATALOG", "CREATE_EXTERNAL_LOCATION"]
  }
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
}
