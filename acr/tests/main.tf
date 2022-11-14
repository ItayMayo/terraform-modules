resource "azurerm_resource_group" "test-rg" {
  name     = "itaym-acr-test"
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
    default = {
      subnet_name      = local.work_subnet_name
      address_prefixes = ["192.166.0.0/24"]
    }
  }

  depends_on = [
    azurerm_resource_group.test-rg,
    module.log-analytics-workspace
  ]
}


module "acr-private-dns" {
  source = "github.com/ItayMayo/terraform-modules//private-dns"

  for_each = { acr_dns = "acr_dns" }

  zone_name           = "privatelink.azurecr.io"
  resource_group_name = azurerm_resource_group.test-rg.name

  vnet_ids = { default = module.vnet.id }

  depends_on = [
    azurerm_resource_group.test-rg,
    module.vnet
  ]
}

module "acr" {
  source = "../"

  name                  = "itaymtestacr"
  private_dns_zone_name = "privatelink.azurecr.io"

  resource_group_name = azurerm_resource_group.test-rg.name
  location            = "westeurope"
  log_workspace_id    = module.log-analytics-workspace.id

  sku = "Premium"

  admin_enabled              = true
  private_endpoint_subnet_id = module.vnet.subnet_ids["default"]

  depends_on = [
    azurerm_resource_group.test-rg,
    module.acr-private-dns,
    module.log-analytics-workspace
  ]
}
