resource "azurerm_resource_group" "test-rg" {
  name     = "itaym-test-rg"
  location = "West Europe"
}

locals {
  work_vnet_name   = "test-vnet"
  work_subnet_name = "default"
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

resource "azurerm_virtual_network" "vnet" {
  name                = "test-vnet"
  resource_group_name = azurerm_resource_group.test-rg.name
  location            = "westeurope"
  address_space       = ["192.166.0.0/16"]

  tags = {
    test = "test"
  }
}

module "diagnostics" {
  source = "../"

  name                       = "test-vnet-diagnostics"
  target_resource_id         = azurerm_virtual_network.vnet.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log-analytics-workspace.id

  depends_on = [
    azurerm_virtual_network.vnet
  ]
}
