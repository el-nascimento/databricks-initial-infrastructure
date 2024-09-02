locals {
  project               = "databricks-cert"
  organization          = "qubika"
}

inputs = {
  project      = local.project
  organization = local.organization
}
