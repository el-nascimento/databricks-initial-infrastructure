terraform {
  required_version = "~> 1.8.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.65.0"
    }

    databricks = {
      source = "databricks/databricks"
      version = "~> 1.51.0"
    }

  }
}

