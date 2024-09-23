
module "default_policy" {
  source = "../databricks_cluster_policy"
  policy = "data-engineering-policy"
  team   = data.databricks_group.engineers.display_name
  pypi_libraries = [
    "dbl-waterbear",
    "dbl-tempo",
    "awswrangler"
  ]
  maven_libraries = [
    "com.databricks.labs:tika-ocr:0.1.6"
  ]
  policy_overrides = jsondecode(file("${path.module}/policies/data-eng-compute-policy.json"))
}
