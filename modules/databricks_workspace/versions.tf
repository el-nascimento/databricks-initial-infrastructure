terraform {
  required_version = "~> 1.8.1"
  required_providers {
    databricks = {
      source = "databricks/databricks"
      version = "~> 1.51.0"
    }
  }
}

