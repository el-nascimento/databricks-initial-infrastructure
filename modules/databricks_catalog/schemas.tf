
resource "databricks_schema" "sandbox" {
  name = "sandbox"
  catalog_name = databricks_catalog.catalog.name
}

resource "databricks_schema" "raw" {
  name = "raw"
  catalog_name = databricks_catalog.catalog.name
}
