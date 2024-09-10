variable "allow_ip_list" { type = list(string) }

variable "use_ip_access_list" { type = bool }

variable "prefix" {
  type = string
  description = "Resource prefix"
}

variable "job_cluster_id" {
  type = string
  description = "ID of the job cluster for the Lakehouse"
}
