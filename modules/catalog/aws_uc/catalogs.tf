
resource "databricks_catalog" "sandbox" {
  name = "sandbox"
  metastore_id = databricks_metastore.this.metastore_id
  isolation_mode = "ISOLATED"
}
