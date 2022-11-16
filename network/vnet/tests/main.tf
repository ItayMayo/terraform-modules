resource "azurerm_resource_group" "test-rg" {
  name     = "itaym-test-rg"
  location = "West Europe"
}

locals {
  nsg                  = jsondecode(file("./nsg.json"))
  route_tables_configs = jsondecode(file("./route_table.json"))
}

resource "azurerm_log_analytics_workspace" "log-analytics-workspace" {
  name                = "test-workspace"
  resource_group_name = azurerm_resource_group.test-rg.name
  location            = "westeurope"
  sku                 = "PerGB2018"

  depends_on = [
    azurerm_resource_group.test-rg
  ]
}

module "route-table" {
  source = "github.com/ItayMayo/terraform-modules//network/route-table"

  for_each = local.route_tables_configs

  route_table_name              = each.value["table_name"]
  location                      = "westeurope"
  resource_group_name           = azurerm_resource_group.test-rg.name
  disable_bgp_route_propagation = each.value["disable_bgp_route_propagation"]
  route_table_routes            = each.value["table_routes"]
  tags                          = { test = "test" }

  depends_on = [
    azurerm_resource_group.test-rg,
  ]
}

module "vnet" {
  source = "../"

  vnet_name           = "test-vnet"
  resource_group_name = azurerm_resource_group.test-rg.name
  location            = "westeurope"
  log_workspace_id    = azurerm_log_analytics_workspace.id
  address_space       = ["192.166.0.0/16"]
  security_groups     = local.nsg

  subnets = {
    default = {
      subnet_name      = "default"
      address_prefixes = ["192.166.0.0/24"]
      nsg_name         = "test-security-group"
      route_table_id   = module.route-table["test_route_table"].id
    }
  }

  depends_on = [
    azurerm_resource_group.test-rg,
    azurerm_log_analytics_workspace
  ]
}


