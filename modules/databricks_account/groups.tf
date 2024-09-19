resource "databricks_group" "account_groups" {
  for_each     = { for x in var.account_level_groups : x => x }
  display_name = each.key
}
