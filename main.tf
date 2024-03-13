resource "azurerm_resource_group" "az_resource_grp" {
  name     = var.resource_group_name
  location = "East US"
}
resource "azurerm_mssql_server" "sql_server" {
  name =  var.sql_server_name
  resource_group_name = azurerm_resource_group.az_resource_grp.name
  location = azurerm_resource_group.az_resource_grp.location
  version = "12.0"
  administrator_login = "vishal"
  administrator_login_password = "spark@2001"
}
resource "azurerm_mssql_database" "sql_db" {
  name = var.az_db_name
  server_id = azurerm_mssql_server.sql_server.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb    = 4
  read_scale     = true
  sku_name       = "S0"
  zone_redundant = true
  enclave_type   = "VBS"

    tags = {
    foo = "bar"
  }

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
}
}