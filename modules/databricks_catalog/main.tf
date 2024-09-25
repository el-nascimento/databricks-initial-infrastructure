
// Catalog
resource "databricks_catalog" "catalog" {
  name           = var.name
  metastore_id   = var.metastore_id
  isolation_mode = "ISOLATED"
  force_destroy  = true
  storage_root   = local.catalog_storage
  depends_on     = [databricks_storage_credential.catalog, databricks_external_location.catalog]
  owner          = data.databricks_group.administrators.display_name
}

resource "databricks_external_location" "catalog" {
  name            = "${local.catalog_bucket}-external-location"
  url             = local.catalog_storage
  credential_name = databricks_storage_credential.catalog.id
  owner           = data.databricks_group.administrators.display_name
  force_destroy   = true
  force_update    = true
}

resource "databricks_storage_credential" "catalog" {
  force_destroy = true
  force_update  = true
  name          = local.catalog_access_role_name
  aws_iam_role {
    role_arn = local.catalog_access_role_arn
  }
  owner = data.databricks_group.administrators.display_name
}

resource "databricks_default_namespace_setting" "this" {
  namespace {
    value = databricks_catalog.catalog.name
  }
}
