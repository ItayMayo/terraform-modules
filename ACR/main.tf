resource "azurerm_container_registry" "acr" {
  name                          = var.acr_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  sku                           = var.acr_sku
  admin_enabled                 = var.admin_enabled
  public_network_access_enabled = var.public_network_access_enabled
  data_endpoint_enabled         = var.data_endpoint_enabled
  tags                          = var.tags
}

locals {
  diagnostics_name = "ACR Diagnostics"
  resource_id      = azurerm_container_registry.acr.id
}

module "diagnostics_module" {
  source = "github.com/ItayMayo/terraform-azure-logger"

  name                       = local.diagnostics_name
  target_resource_id         = local.resource_id
  log_analytics_workspace_id = var.log_workspace_id
}
