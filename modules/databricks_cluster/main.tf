
resource "databricks_cluster" "this" {
  spark_version                = local.spark_version
  node_type_id                 = var.cluster_config.node_type_id
  cluster_name                 = "${var.prefix}-${var.cluster_config.cluster_name}"
  runtime_engine               = var.cluster_config.runtime_engine
  autotermination_minutes      = var.cluster_config.autotermination_minutes
  num_workers                  = var.cluster_config.num_workers
  enable_elastic_disk          = var.cluster_config.enable_elastic_disk
  enable_local_disk_encryption = var.cluster_config.enable_local_disk_encryption
  policy_id                    = var.cluster_config.cluster_policy_id
  data_security_mode           = var.cluster_config.data_security_mode
  single_user_name             = local.single_user_name
  idempotency_token            = random_uuid.idempotency_token.result
  spark_conf                   = local.spark_conf
  custom_tags                  = local.custom_tags
  autoscale {
    max_workers = var.cluster_config.autoscale.max_workers
    min_workers = var.cluster_config.autoscale.min_workers
  }
  aws_attributes {
    availability = var.cluster_config.aws_availability
  }
}

resource "random_uuid" "idempotency_token" {}
