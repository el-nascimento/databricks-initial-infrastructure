
resource "databricks_cluster_policy" "this" {
  name       = var.policy
  definition = jsonencode(merge(local.default_policy, var.policy_overrides))
  max_clusters_per_user = var.max_clusters_per_user

  dynamic "libraries" {
    for_each = { for x in var.pypi_libraries : x => x }
    content {
      pypi {
        package = libraries.key
      }
    }
  }

  dynamic "libraries" {
    for_each = { for x in var.maven_libraries : x => x }
    content {
      maven {
        coordinates = libraries.key
      }
    }
  }

}

resource "databricks_permissions" "can_use_cluster_policy" {
  cluster_policy_id = databricks_cluster_policy.this.id
  access_control {
    group_name       = var.team
    permission_level = "CAN_USE"
  }
}
