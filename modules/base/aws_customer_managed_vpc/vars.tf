variable "databricks_account_id" {
  type        = string
  description = <<DESC
  The ID per Databricks AWS account used for accessing account management APIs. 
  After the AWS E2 account is created, this is available after logging into [https://accounts.cloud.databricks.com](https://accounts.cloud.databricks.com).
  DESC
}

# variable "databricks_account_username" {
#   type = string
#   description = "E2 account admin email address"
# }

# variable "databricks_account_password" {
#   type = string
#   description = "E2 account admin password"
# }

variable "workspace_vpce_service" {
  type        = string
  description = <<DESC
  VPC endpoint service for workspace communication. This is region-dependent. 
  For example, for us-east-1 the service is available on the Databricks Private Link [documentation](https://docs.databricks.com/administration-guide/cloud-configurations/aws/privatelink.html#create-the-aws-vpc-endpoints-for-your-aws-region)
  `com.amazonaws.vpce.us-east-1.vpce-svc-09143d1e626de2f04`
  DESC
}

variable "relay_vpce_service" {
  type        = string
  description = <<DESC
  VPC endpoint service for backend relays. This is region-dependent.
  For example, for us-east-1 the service is available on the Databricks Private Link [documentation](https://docs.databricks.com/administration-guide/cloud-configurations/aws/privatelink.html#create-the-aws-vpc-endpoints-for-your-aws-region)
  `com.amazonaws.vpce.us-east-1.vpce-svc-09143d1e626de2f04`
  DESC
}

variable "vpce_subnet_cidr" {
  description = "CIDR for deployment of the VPC endpoint subnets"
  type        = string
}

variable "private_dns_enabled" {
  default = true
  type    = bool
}

variable "tags" { default = {} }

variable "cidr_block" {
  # default = "10.4.0.0/16"
  type = string
}

variable "vpc_id" {
  description = "VPC identifier for existing customer managed VPC"
  type        = string
}

variable "subnet_ids" {
  description = "private subnets associated with the Databricks-compliant VPC. This should be a list of strings"
  type        = list(string)
}

variable "security_group_id" {
  description = "security group ID used for VPC subnets"
  type        = string
}

variable "cross_account_arn" {
  description = "Existing cross-account IAM role ARN"
  type        = string
}

variable "region" {
  type = string
}

variable "project" {
  type = string
}

variable "organization" {
  type = string
}

locals {
  prefix = "${var.organization}-${var.project}-${var.region}-private-link-ws"
}
