
resource "databricks_permissions" "base_users" {
  cluster_id = databricks_cluster.this.id

  dynamic "access_control" {
    for_each = { for x in var.user_groups : x => x }
    content {
      group_name       = each.key
      permission_level = "CAN_ATTACH_TO"
    }
  }

  dynamic "access_control" {
    for_each = { for x in var.power_user_groups : x => x }
    content {
      group_name       = each.key
      permission_level = "CAN_RESTART"
    }
  }

  dynamic "access_control" {
    for_each = { for x in var.admin_groups : x => x }
    content {
      group_name       = each.key
      permission_level = "CAN_MANAGE"
    }
  }

}
