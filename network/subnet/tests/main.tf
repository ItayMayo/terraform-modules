resource "azurerm_resource_group" "test-rg" {
  name     = "itaym-test-rg"
  location = "West Europe"
}

locals {
  nsg                  = jsondecode(file("./nsg.json"))
  route_tables_configs = jsondecode(file("./route_table.json"))
}

module "test-nsg" {
  source = "github.com/ItayMayo/terraform-modules//network/security-group"

  nsg_name            = "test-security-group"
  location            = "westeurope"
  resource_group_name = azurerm_resource_group.test-rg.name

  nsg_security_rules = local.nsg["test-security-group"]

  tags = { test = "test" }
}

module "route-table" {
  source = "github.com/ItayMayo/terraform-modules//network/route-table"

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

resource "azurerm_virtual_network" "vnet" {
  name                = "test-vnet"
  resource_group_name = azurerm_resource_group.test-rg.name
  location            = "westeurope"

  address_space = ["192.166.0.0/16"]

  tags = { test = "test" }

  depends_on = [
    azurerm_resource_group.test-rg
  ]
}

module "subnets" {
  source = "../"

  resource_group_name  = azurerm_resource_group.test-rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  name                 = "default"
  address_prefixes     = ["192.166.0.0/24"]
  nsg_id               = module.test-nsg.id
  route_table_id       = module.route-table["test_route_table"].id

  depends_on = [
    azurerm_virtual_network.vnet,
    module.test-nsg,
    module.route-table
  ]
}



