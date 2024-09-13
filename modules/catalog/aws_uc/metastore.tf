resource "databricks_metastore" "this" {
  name          = "primary"
  storage_root  = "s3://${aws_s3_bucket.metastore.id}/metastore"
  force_destroy = true
}


resource "databricks_metastore_data_access" "this" {
  metastore_id = databricks_metastore.this.id
  name         = aws_iam_role.metastore_data_access.name
  aws_iam_role {
    role_arn = aws_iam_role.metastore_data_access.arn
  }
  is_default = true
}

resource "databricks_metastore_assignment" "default_metastore" {
  for_each             = { for x in var.workspaces_to_associate : x => x }
  workspace_id         = each.key
  metastore_id         = databricks_metastore.this.id
  default_catalog_name = "hive_metastore"
}
