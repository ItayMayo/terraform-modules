resource "azurerm_resource_group" "test-rg" {
  name     = "itaym-test-rg"
  location = "West Europe"
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

module "vnet" {
  source = "github.com/ItayMayo/terraform-modules//network/vnet"

  vnet_name           = "test-vnet"
  resource_group_name = azurerm_resource_group.test-rg.name
  location            = "westeurope"
  log_workspace_id    = azurerm_log_analytics_workspace.log-analytics-workspace.id
  address_space       = ["192.166.0.0/16"]

  subnets = {
    default = {
      subnet_name      = "default"
      address_prefixes = ["192.166.0.0/24"]
    }
  }

  depends_on = [
    azurerm_resource_group.test-rg,
    azurerm_log_analytics_workspace.log-analytics-workspace
  ]
}

module "test-vm" {
  source = "../"

  vm_name                            = "test-vm"
  resource_group_name                = azurerm_resource_group.test-rg.name
  location                           = "westeurope"
  log_workspace_id                   = azurerm_log_analytics_workspace.log-analytics-workspace.id
  vm_os_name                         = "Windows"
  vm_admin_username                  = "empire"
  vm_admin_password                  = "Empire6!"
  vm_disable_password_authentication = false
  nic_subnet_id                      = module.vnet.subnet_ids["default"]

  vm_source_image_reference = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  tags = { test = "test" }

  depends_on = [
    azurerm_resource_group.test-rg,
    module.vnet,
    azurerm_log_analytics_workspace.log-analytics-workspace
  ]
}
