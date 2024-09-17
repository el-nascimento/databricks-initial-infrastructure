
resource "databricks_catalog" "catalog" {
  name = local.catalog_name
  storage_root = "s3://${var.metastore_data_bucket}/${local.catalog_name}"
  metastore_id = var.metastore_id
  isolation_mode = "ISOLATED"
  force_destroy = true
}
