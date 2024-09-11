// Log delivery storage
data "databricks_aws_assume_role_policy" "logdelivery" {
  for_log_delivery = true
  external_id = var.databricks_account_id
}

resource "aws_iam_role" "logdelivery" {
  name = "${local.prefix}-logdelivery"
  description = "${local.prefix} Log Delivery"
  assume_role_policy = data.databricks_aws_assume_role_policy.logdelivery.json
}

data "databricks_aws_bucket_policy" "logdelivery" {
  bucket = var.logdelivery_bucket_name
  full_access_role = aws_iam_role.logdelivery.arn
}

resource "aws_s3_bucket_policy" "logdelivery" {
  bucket = var.logdelivery_bucket_name
  policy = data.databricks_aws_bucket_policy.logdelivery.json
}

resource "databricks_mws_credentials" "log_writer" {
  credentials_name = "${local.prefix}-log-delivery-creds"
  role_arn = aws_iam_role.logdelivery.arn
}

resource "databricks_mws_storage_configurations" "log_bucket" {
  account_id = var.databricks_account_id
  storage_configuration_name = "Usage Logs"
  bucket_name = var.logdelivery_bucket_name
}

resource "databricks_mws_log_delivery" "usage_logs" {
  account_id = var.databricks_account_id
  credentials_id = databricks_mws_credentials.log_writer.credentials_id
  storage_configuration_id = databricks_mws_storage_configurations.log_bucket.storage_configuration_id
  delivery_path_prefix = "billable-usage"
  config_name = "Usage Logs"
  log_type = "BILLABLE_USAGE"
  output_format = "CSV"
}

resource "databricks_mws_log_delivery" "audit_logs" {
  account_id = var.databricks_account_id
  credentials_id = databricks_mws_credentials.log_writer.credentials_id
  storage_configuration_id = databricks_mws_storage_configurations.log_bucket.storage_configuration_id
  delivery_path_prefix = "audit-logs"
  config_name = "Audit Logs"
  log_type = "AUDIT_LOGS"
  output_format = "JSON"
}
