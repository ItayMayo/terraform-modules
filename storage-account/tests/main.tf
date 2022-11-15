resource "azurerm_resource_group" "test-rg" {
  name     = "itaym-test-rg"
  location = "West Europe"
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
    default = {
      subnet_name      = "default"
      address_prefixes = ["192.166.0.0/24"]
    }
  }

  depends_on = [
    azurerm_resource_group.test-rg,
    module.log-analytics-workspace
  ]
}

module "storage-account" {
  source = "../"

  name                = "itaymteststorageaccount"
  resource_group_name = azurerm_resource_group.test-rg.name

  location         = "westeurope"
  log_workspace_id = module.log-analytics-workspace.id

  endpoint_ip_address        = "192.166.0.66"
  private_endpoint_subnet_id = module.vnet.subnet_ids["default"]

  tags = { test = "test" }

  depends_on = [
    azurerm_resource_group.test-rg,
    module.vnet,
    module.log-analytics-workspace
  ]
}


