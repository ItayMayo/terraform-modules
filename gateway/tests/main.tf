resource "azurerm_resource_group" "test-rg" {
  name     = "itaym-test-rg"
  location = "West Europe"
}

locals {
  work_vnet_name   = "test-vnet"
  work_subnet_name = "default"
}

module "log-analytics-workspace" {
  source = "github.com/ItayMayo/terraform-modules//analytics-workspace"

  name = "test-log-analytics"

  resource_group_name = azurerm_resource_group.test-rg.name
  location            = "westeurope"

  depends_on = [
    azurerm_resource_group.test-rg
  ]
}

module "vnet" {
  source = "github.com/ItayMayo/terraform-modules//network/vnet"

  vnet_name           = "test-vnet"
  resource_group_name = azurerm_resource_group.test-rg.name

  location         = "westeurope"
  log_workspace_id = module.log-analytics-workspace.id

  address_space = ["192.166.0.0/16"]

  subnets = {
    GatewaySubnet = {
      subnet_name      = "GatewaySubnet"
      address_prefixes = ["192.166.0.0/27"]
    }
  }

  depends_on = [
    azurerm_resource_group.test-rg,
    module.log-analytics-workspace
  ]
}

module "vpn-gateway" {
  source = "../"

  name = "test-vpn-gateway"

  resource_group_name = azurerm_resource_group.test-rg.name
  location            = "westeurope"
  log_workspace_id    = module.log-analytics-workspace.id

  gateway_subnet_id = module.vnet.subnet_ids["GatewaySubnet"]

  enable_point_to_site = true
  vpn_client_configuration = {
    address_space    = ["166.6.0.0/24"]
    auth_types       = ["AAD"]
    client_protocols = ["OpenVPN"]
  }

  tags = { test = "test" }

  depends_on = [
    azurerm_resource_group.test-rg,
    module.vnet,
    module.log-analytics-workspace
  ]
}
