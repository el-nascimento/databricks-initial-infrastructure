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
      version = "~> 3.6.2"
    }

    # WARN: no support for apple silicon
    # template = {
    #   source  = "hashicorp/template"
    #   version = "~> 2.2.0"
    # }

    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.5.0"
    }

    http = {
      source  = "hashicorp/http"
      version = "~> 3.4.4"
    }

    local = {
      source  = "hashicorp/local"
      version = "~> 2.5.1"
    }

  }
}

