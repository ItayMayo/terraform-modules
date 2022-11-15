resource "azurerm_resource_group" "test-rg" {
  name     = "itaym-test-rg"
  location = "West Europe"
}

locals {
  route_tables_configs = jsondecode(file("./route_table.json"))
}

module "route-tables" {
  source = "../"

  for_each = local.route_tables_configs

  route_table_name = each.value["table_name"]

  location            = "westeurope"
  resource_group_name = azurerm_resource_group.test-rg.name

  disable_bgp_route_propagation = each.value["disable_bgp_route_propagation"]
  route_table_routes            = each.value["table_routes"]

  tags = { test = "test" }

  depends_on = [
    azurerm_resource_group.test-rg,
  ]
}
