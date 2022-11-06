resource "azurerm_network_interface" "nic" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  ip_configuration {
    name                          = var.ip_configuration_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
  }
}

locals {
  diagnostics_name   = "Network Interface Diagnostics"
  target_resource_id = azurerm_network_interface.nic.id
}

module "diagnostics_module" {
  source = "github.com/ItayMayo/terraform-modules/tree/master/diagnostic-settings"

  name                       = local.diagnostics_name
  target_resource_id         = local.resource_id
  log_analytics_workspace_id = var.log_workspace_id
}
