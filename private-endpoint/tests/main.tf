resource "azurerm_resource_group" "test-rg" {
  name     = "itaym-test-rg"
  location = "West Europe"
}

module "vnet" {
  source = "github.com/ItayMayo/terraform-modules//network/vnet"

  vnet_name           = "test-vnet"
  resource_group_name = azurerm_resource_group.test-rg.name
  location            = "westeurope"
  log_workspace_id    = null
  address_space       = ["192.166.0.0/16"]

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

resource "azurerm_storage_account" "storage_account" {
  name                            = "itaymteststorageaccount"
  resource_group_name             = azurerm_resource_group.test-rg.name
  location                        = "westeurope"
  account_tier                    = "Standard"
  account_kind                    = "StorageV2"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = false
}


module "private_endpoint" {
  source = "../"

  location                   = "westeurope"
  resource_group_name        = azurerm_resource_group.test-rg.name
  name                       = "test-endpoint"
  private_endpoint_subnet_id = module.vnet.subnet_ids["default"]
  subresource_names          = ["blob"]
  target_resource_id         = azurerm_storage_account.storage_account.id

  depends_on = [
    azurerm_storage_account.storage_account
  ]
}
