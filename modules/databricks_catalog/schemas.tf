
resource "databricks_schema" "sandbox" {
  name         = "sandbox"
  catalog_name = databricks_catalog.catalog.name
  owner        = data.databricks_group.administrators.display_name
}

resource "databricks_schema" "raw" {
  name         = "raw"
  catalog_name = databricks_catalog.catalog.name
  owner        = data.databricks_group.administrators.display_name
}
