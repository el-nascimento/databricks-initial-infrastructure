variable "prefix" {
  type = string
}

variable "cluster_config" {
  type = object({
    spark_version                = optional(string)
    node_type_id                 = optional(string)
    cluster_name                 = string
    num_workers                  = optional(number)
    runtime_engine               = optional(string)
    enable_elastic_disk          = optional(bool)
    enable_local_disk_encryption = optional(bool)
    data_security_mode           = optional(string)
    single_user_name             = optional(string)
    autotermination_minutes      = optional(number)
    spark_conf                   = optional(map(string))
    custom_tags                  = optional(map(string))
  })
}

data "databricks_spark_version" "latest" {
  latest = true
}

data "databricks_node_type" "smallest" {
  local_disk = true
}

locals {
  spark_version           = var.cluster_config.spark_version != null ? var.cluster_config.spark_version : data.databricks_spark_version.latest.id
  node_type_id            = var.cluster_config.node_type_id != null ? var.cluster_config.node_type_id : data.databricks_node_type.smallest.id
  autotermination_minutes = var.cluster_config.autotermination_minutes != null ? var.cluster_config.autotermination_minutes : 10
  runtime_engine          = var.cluster_config.runtime_engine != null ? var.cluster_config.runtime_engine : "STANDARD"
  num_workers             = var.cluster_config.num_workers != null ? var.cluster_config.num_workers : 0
  single_node_spark_conf = {
    "spark.databricks.cluster.profile" : "singleNode"
    "spark.master" : "local[*]"
  }
  spark_conf = local.num_workers == 0 ? merge(var.cluster_config.spark_conf, local.single_node_spark_conf) : var.cluster_config.spark_conf
  single_node_custom_tags = {
    "ResourceClass" = "SingleNode"
  }
  custom_tags        = local.num_workers == 0 ? merge(var.cluster_config.custom_tags, local.single_node_custom_tags) : var.cluster_config.custom_tags
  data_security_mode = local.num_workers == 0 ? "SINGLE_USER" : var.cluster_config.data_security_mode != null ? var.cluster_config.data_security_mode : "SINGLE_USER"
  single_user_name   = local.data_security_mode == "SINGLE_USER" ? var.cluster_config.single_user_name : null
}
