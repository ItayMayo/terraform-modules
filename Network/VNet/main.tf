resource "azurerm_virtual_network" "vnet" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.resource_location

  address_space = var.address_space
  dns_servers   = var.dns_servers

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

module "logger_module" {
  source = "github.com/ItayMayo/terraform-azure-logger"

  name                       = "Diagnostics"
  target_resource_id         = azurerm_virtual_network.vnet.id
  log_analytics_workspace_id = var.log_workspace_id
}
