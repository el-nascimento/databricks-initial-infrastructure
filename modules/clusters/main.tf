
module "clusters" {
  for_each = var.cluster_configs
  source = "../databricks_cluster"
  cluster_config = {
    // NOTE: spark_version is provided by the policy
    cluster_name       = each.key
    num_workers        = each.value.workers
    cluster_policy_id  = module.default_policy.policy_id
    data_security_mode = "USER_ISOLATION"
  }
  use_lts_runtime = true
  prefix          = var.prefix
}
