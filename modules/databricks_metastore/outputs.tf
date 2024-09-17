output "databricks_metastore_id" {
  value = module.aws_uc.databricks_metastore_id
}

output "databricks_storage_credential" {
  value = module.aws_uc.databricks_storage_credential
}

output "databricks_external_location" {
  value = module.aws_uc.databricks_external_location
}

output "databricks_metastore_storage_root" {
  value = module.aws_uc.databricks_metastore_storage_root
}

output "metastore_data_bucket" {
  value = module.aws_uc.metastore_data_bucket
}
