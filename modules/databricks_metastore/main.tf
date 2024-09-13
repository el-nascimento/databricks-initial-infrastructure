data "databricks_metastore" "default" {
  region = var.region
}

resource "databricks_catalog" "this" {
  name         = var.catalog_name
  metastore_id = data.databricks_metastore.default.metastore_id
  storage_root = "s3://${module.catalog_bucket.s3_bucket_id}/catalog"
}
