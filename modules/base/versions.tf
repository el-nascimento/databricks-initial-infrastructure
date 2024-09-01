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

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.5"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 2.3.0"
    }

    template = {
      source  = "hashicorp/template"
      version = "~> 2.1.2"
    }

    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.0.0"
    }

    http = {
      source  = "hashicorp/http"
      version = "~> 1.1.1"
    }

    local = {
      source  = "hashicorp/local"
      version = "~> 1.4.0"
    }

  }
}

