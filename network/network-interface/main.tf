/**
* # Network Interface
*/

locals {
  ip_address_provided           = var.private_ip_address != null
  private_ip_address_allocation = local.ip_address_provided ? "Static" : "Dynamic"
}

resource "azurerm_network_interface" "network_interface" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  ip_configuration {
    name                          = var.ip_configuration_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = local.private_ip_address_allocation
    private_ip_address            = var.private_ip_address
  }

  tags = var.tags
}

resource "azurerm_network_interface_security_group_association" "nsg_association" {
  count = var.nsg_id != null ? 1 : 0

  network_interface_id      = azurerm_network_interface.network_interface.id
  network_security_group_id = var.nsg_id

  depends_on = [
    azurerm_network_interface.network_interface
  ]
}

locals {
  diagnostics_name               = "${var.name}-nic-diagnostics"
  diagnostics_workspace_provided = var.log_workspace_id != null
}

module "diagnostics" {
  source   = "github.com/ItayMayo/terraform-modules//diagnostic-settings"
  
  count = local.diagnostics_workspace_provided ? 1 : 0

  name                       = local.diagnostics_name
  target_resource_id         = azurerm_network_interface.network_interface.id
  log_analytics_workspace_id = var.log_workspace_id

  depends_on = [
    azurerm_network_interface.network_interface
  ]
}
