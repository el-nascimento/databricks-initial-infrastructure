
module "ingestion_cluster" {
  source = "../databricks_cluster"
  cluster_config = {
    // NOTE: spark_version is provided by the policy
    cluster_name       = "sandbox-cluster"
    num_workers        = 3
    cluster_policy_id  = module.default_policy.policy_id
    data_security_mode = "USER_ISOLATION"
  }
  use_lts_runtime = true
  prefix          = var.prefix
}
