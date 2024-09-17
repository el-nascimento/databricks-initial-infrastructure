resource "databricks_grants" "metastore" {
  metastore = databricks_metastore.this.metastore_id
  grant {
    principal = "DataEngineers"
    privileges = ["CREATE_CATALOG", "CREATE_EXTERNAL_LOCATION"]
  }
}
