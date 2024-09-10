output "idempotency_token" {
  value = random_uuid.idempotency_token.result
}

output "cluster_id" {
  value = databricks_cluster.this.cluster_id
}
