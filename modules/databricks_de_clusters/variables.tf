data "databricks_group" "engineers" {
  display_name = "DataEngineers"
}

variable "prefix" {
  type        = string
  description = "Resource prefix"
}

variable "cluster_configs" {
  type = map(object({
    workers = object({
      max = number
      min = number
    })
  }))
  description = "Configuration for clusters"
}
