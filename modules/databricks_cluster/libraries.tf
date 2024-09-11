
resource "databricks_library" "pypi_libraries" {
  for_each = {for x in var.pypi_libraries : x => x}
  cluster_id = databricks_cluster.this.id
  pypi {
    package = each.key
  }
}

resource "databricks_library" "jar_libraries" {
  for_each = {for x in var.maven_libraries : x => x}
  cluster_id = databricks_cluster.this.id
  maven {
    coordinates = each.key
  }
}
