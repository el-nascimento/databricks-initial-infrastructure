resource "databricks_metastore" "this" {
  name          = "main"
  storage_root  = "s3://${aws_s3_bucket.metastore.id}/metastore"
  force_destroy = true
  region        = var.region
}


resource "databricks_metastore_data_access" "this" {
  metastore_id  = databricks_metastore.this.id
  force_destroy = true
  force_update  = true
  name          = aws_iam_role.metastore_data_access.name
  aws_iam_role {
    role_arn = aws_iam_role.metastore_data_access.arn
  }
  is_default = true
}

resource "databricks_metastore_assignment" "default_metastore" {
  workspace_id         = var.databricks_host_id
  metastore_id         = databricks_metastore.this.id
  default_catalog_name = "hive_metastore"
}
