
resource "databricks_cluster" "this" {
  spark_version                = local.spark_version
  node_type_id                 = local.node_type_id
  cluster_name                 = var.cluster_config.cluster_name
  runtime_engine               = local.runtime_engine
  autotermination_minutes      = local.autotermination_minutes
  num_workers                  = local.num_workers
  enable_elastic_disk          = var.cluster_config.enable_elastic_disk == null ? false : true
  enable_local_disk_encryption = var.cluster_config.enable_local_disk_encryption == null ? false : true
  data_security_mode           = local.data_security_mode
  single_user_name             = local.single_user_name
  idempotency_token            = random_uuid.idempotency_token.result
  spark_conf                   = local.spark_conf
  custom_tags                  = local.custom_tags
  aws_attributes {
    availability = local.aws_availability
  }
}

resource "random_uuid" "idempotency_token" {}
