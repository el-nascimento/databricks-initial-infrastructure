
resource "databricks_catalog" "catalog" {
  name           = var.name
  metastore_id   = var.metastore_id
  isolation_mode = "OPEN"
  force_destroy  = true
  # storage_root = "s3://${var.metastore_data_bucket}/${local.catalog_name}"
}

resource "databricks_grants" "catalog" {
  catalog = databricks_catalog.catalog.name
  grant {
    principal  = "DataEngineers"
    privileges = ["ALL_PRIVILEGES"]
  }
}
