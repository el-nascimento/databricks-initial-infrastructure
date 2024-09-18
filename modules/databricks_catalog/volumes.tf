//Raw data volume
resource "databricks_external_location" "raw_data" {
  name            = "${module.raw_bucket.s3_bucket_id}-external-location"
  url             = "s3://${module.raw_bucket.s3_bucket_id}/"
  credential_name = databricks_storage_credential.raw_data.id
  owner           = data.databricks_group.administrators.display_name
}

resource "databricks_storage_credential" "raw_data" {
  force_destroy = true
  force_update  = true
  name          = aws_iam_role.raw_data_access.name
  aws_iam_role {
    role_arn = aws_iam_role.raw_data_access.arn
  }
  owner = data.databricks_group.administrators.display_name
}

resource "databricks_volume" "raw_data" {
  catalog_name     = databricks_catalog.catalog.name
  schema_name      = databricks_schema.raw.name
  name             = "data"
  volume_type      = "EXTERNAL"
  storage_location = databricks_external_location.raw_data.url
  owner            = data.databricks_group.administrators.display_name
  comment          = "Raw data mounted from s3 bucket"
}

// Sandbox data volume
resource "databricks_external_location" "sandbox_data" {
  name            = "${module.sandbox_bucket.s3_bucket_id}-external-location"
  url             = "s3://${module.sandbox_bucket.s3_bucket_id}/"
  credential_name = databricks_storage_credential.sandbox_data.id
  owner           = data.databricks_group.administrators.display_name
}

resource "databricks_storage_credential" "sandbox_data" {
  force_destroy = true
  force_update  = true
  name          = aws_iam_role.sandbox_data_access.name
  aws_iam_role {
    role_arn = aws_iam_role.sandbox_data_access.arn
  }
  owner = data.databricks_group.administrators.display_name
}

resource "databricks_volume" "sandbox_data" {
  catalog_name     = databricks_catalog.catalog.name
  schema_name      = databricks_schema.sandbox.name
  name             = "data"
  volume_type      = "EXTERNAL"
  storage_location = databricks_external_location.sandbox_data.url
  owner            = data.databricks_group.administrators.display_name
  comment          = "Sandbox data mounted from s3 bucket"
}
