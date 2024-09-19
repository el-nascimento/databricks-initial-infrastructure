variable "policy" {
  description = "Policy name"
  type        = string
}

variable "team" {
  description = "Team that performs the work"
  type        = string
}

variable "policy_overrides" {
  description = "Cluster policy overrides"
}

variable "max_clusters_per_user" {
  description = "Maximum number of clusters a user can create"
  default     = null
  type        = number
  validation {
    condition     = var.max_clusters_per_user == null ? true : var.max_clusters_per_user > 0
    error_message = <<EOF
    max_clusters_per_user is invalid, has to be null or
    greater than 0: ${var.max_clusters_per_user == null ? "" : tostring(var.max_clusters_per_user)}
    EOF
  }
}

variable "maven_libraries" {
  type    = list(string)
  default = []
}

variable "pypi_libraries" {
  type    = list(string)
  default = []
}


locals {
  default_policy = {
    "dbus_per_hour" : {
      "type" : "range",
      "maxValue" : 10
    },
    "autotermination_minutes" : {
      "type" : "fixed",
      "value" : 30,
      "hidden" : false
    },
    "custom_tags.team" : {
      "type" : "fixed",
      "value" : var.team
    }
  }
}
