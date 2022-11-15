resource "azurerm_resource_group" "test-rg" {
  name     = "itaym-test-rg"
  location = "West Europe"
}

module "vnet" {
  source = "github.com/ItayMayo/terraform-modules//network/vnet"

  vnet_name           = "test-vnet"
  resource_group_name = azurerm_resource_group.test-rg.name

  location = "westeurope"

  address_space = ["192.166.0.0/16"]

  subnets = {
    default = {
      subnet_name      = "default"
      address_prefixes = ["192.166.0.0/24"]
    }
  }

  depends_on = [
    azurerm_resource_group.test-rg
  ]
}

module "private-dns" {
  source = "../"

  zone_name           = "privatelink.testzone.io"
  resource_group_name = azurerm_resource_group.test-rg.name

  vnet_ids = { vnet = module.vnet.id }
  tags     = { test = "test" }

  depends_on = [
    azurerm_resource_group.test-rg,
    module.vnet
  ]
}
