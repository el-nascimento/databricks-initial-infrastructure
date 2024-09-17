
resource "databricks_catalog" "catalog" {
  name           = var.name
  metastore_id   = var.metastore_id
  isolation_mode = "ISOLATED"
  force_destroy  = true
  storage_root   = "s3://${module.bucket.s3_bucket_id}/metastore"
  depends_on     = [databricks_storage_credential.catalog, databricks_external_location.catalog]
}

resource "databricks_external_location" "catalog" {
  name            = "${local.catalog_bucket}-external-location"
  url             = "s3://${module.bucket.s3_bucket_id}/metastore"
  credential_name = databricks_storage_credential.catalog.id
}

resource "databricks_storage_credential" "catalog" {
  force_destroy = true
  force_update  = true
  name          = aws_iam_role.catalog_data_access.name
  aws_iam_role {
    role_arn = aws_iam_role.catalog_data_access.arn
  }
}

resource "databricks_grants" "catalog" {
  catalog = databricks_catalog.catalog.name
  grant {
    principal  = "DataEngineers"
    privileges = ["ALL_PRIVILEGES"]
  }
  depends_on = [databricks_catalog.catalog]
}

resource "databricks_workspace_binding" "catalog" {
  workspace_id = var.databricks_host_id
  securable_type = "catalog"
  securable_name = databricks_catalog.catalog.name
}
