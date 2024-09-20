variable "prefix" {
  type = string
}

variable "user_groups" {
  type        = list(string)
  description = "List of groups that can attach to the cluster"
  default     = []
}

variable "power_user_groups" {
  type        = list(string)
  description = "List of groups that can attach and restart the cluster"
  default     = []
}

variable "admin_groups" {
  type        = list(string)
  description = "List of groups that can manage the cluster"
  default     = []
}

variable "cluster_config" {
  description = <<EOF
  Cluster configuration object. Includes many configuration attributes.
  If only cluster name is provided will create a single-node cluster.
  EOF
  type = object({
    node_type_id                 = optional(string)
    cluster_policy_id            = optional(string)
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
    aws_availability             = optional(string)
  })
}

variable "spark_version" {
  type        = string
  default     = null
  description = "Version of spark for the runtime"
}

variable "use_lts_runtime" {
  default     = true
  type        = bool
  description = "Use an LTS runtime"
}

variable "maven_libraries" {
  type    = list(string)
  default = []
}

variable "pypi_libraries" {
  type    = list(string)
  default = []
}

data "databricks_spark_version" "latest" {
  latest            = true
  long_term_support = var.use_lts_runtime
  spark_version     = var.spark_version
}

locals {
  spark_version = var.spark_version != null ? var.spark_version : data.databricks_spark_version.latest.id
  single_node_spark_conf = {
    "spark.databricks.cluster.profile" : "singleNode"
    "spark.master" : "local[*]"
  }
  spark_conf = var.cluster_config.num_workers == 0 ? merge(var.cluster_config.spark_conf, local.single_node_spark_conf) : var.cluster_config.spark_conf
  single_node_custom_tags = {
    "ResourceClass" = "SingleNode"
  }
  custom_tags      = var.cluster_config.num_workers == 0 ? merge(var.cluster_config.custom_tags, local.single_node_custom_tags) : var.cluster_config.custom_tags
  single_user_name = var.cluster_config.data_security_mode == "SINGLE_USER" ? var.cluster_config.single_user_name : null
}
