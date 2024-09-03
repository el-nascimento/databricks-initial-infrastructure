output "databricks_host_id" {
  value = module.aws_base.databricks_host_id
}

output "databricks_host" {
  value = module.aws_base.databricks_host
}

output "databricks_host_name" {
  value       = module.aws_base.databricks_host_name
  description = "Workspace Name"
}

output "databricks_token" {
  value       = module.aws_base.databricks_token
  sensitive   = true
  description = "Databricks workspace management token"
}

output "security_group" {
  value       = module.aws_base.security_group
  description = "Security group ID for DB Compliant VPC"
}

output "vpc_id" {
  value       = module.aws_base.vpc_id
  description = "VPC ID"
}

output "subnets" {
  value       = module.aws_base.subnets
  description = "private subnets for workspace creation"
}

output "cross_account_role_arn" {
  value       = module.aws_base.cross_account_role_arn
  description = "Cross account IAM role for Databricks workspace deployment"
}

output "root_bucket" {
  value       = module.aws_base.root_bucket
  description = "root bucket"
}
