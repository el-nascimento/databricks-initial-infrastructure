
module "clusters" {
  for_each = var.cluster_configs
  source = "../databricks_cluster"
  cluster_config = {
    // NOTE: spark_version is provided by the policy
    cluster_name       = each.key
    cluster_policy_id  = module.default_policy.policy_id
    data_security_mode = "USER_ISOLATION"
    runtime_engine = "STANDARD"
    autoscale = {
      max_workers = each.value.workers.max
      min_workers = each.value.workers.min
    }
  }
  use_lts_runtime = true
  power_user_groups = [
    data.databricks_group.engineers.display_name
  ]
  prefix          = var.prefix
}
