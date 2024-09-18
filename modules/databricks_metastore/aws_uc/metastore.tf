resource "databricks_metastore" "this" {
  name = "main"
  # storage_root  = "s3://${aws_s3_bucket.metastore.id}/metastore"
  force_destroy = true
  region        = var.region
  owner         = data.databricks_group.administrators.display_name
}
