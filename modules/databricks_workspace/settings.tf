resource "databricks_automatic_cluster_update_workspace_setting" "this" {
  automatic_cluster_update_workspace {
    enabled                              = true
    restart_even_if_no_updates_available = true
    maintenance_window {
      week_day_based_schedule {
        day_of_week = "SUNDAY"
        frequency   = "EVERY_WEEK"
        window_start_time {
          hours   = 1
          minutes = 0
        }
      }
    }
  }
}

# resource "databricks_workspace_conf" "this" {
#   custom_config = {
#     "enableIpAccessLists": false
#     "enableTokensConfig": true
#   }
# }
