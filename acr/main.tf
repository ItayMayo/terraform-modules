/**
  * # ACR Module
*/

locals {
  public_network_enabled = false
}

resource "azurerm_container_registry" "acr" {
  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  sku                           = var.sku
  admin_enabled                 = var.admin_enabled
  public_network_access_enabled = local.public_network_enabled
  tags                          = var.tags
}

locals {
  endpoint_name        = "${azurerm_container_registry.acr.name}-private-endpoint"
  is_manual_connection = false
  subresource_names    = ["registry"]
}

resource "azurerm_private_endpoint" "endpoint" {
  name                = local.endpoint_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = local.endpoint_name
    private_connection_resource_id = azurerm_container_registry.acr.id
    is_manual_connection           = local.is_manual_connection
    subresource_names              = local.subresource_names
  }

  tags = var.tags

  depends_on = [
    azurerm_container_registry.acr
  ]
}

locals {
  normal_record_name = lower(azurerm_container_registry.acr.name)
  dns_record_ttl     = 3600

  zone_a_records = {
    acr_normal_record = {
      name    = local.normal_record_name
      ttl     = local.dns_record_ttl
      records = [azurerm_private_endpoint.endpoint.private_service_connection[0].private_ip_address]
    }
  }
}

resource "azurerm_private_dns_a_record" "a_record" {
  for_each = local.zone_a_records

  name                = each.value["name"]
  zone_name           = var.private_dns_zone_name
  resource_group_name = var.resource_group_name
  ttl                 = each.value["ttl"]
  records             = each.value["records"]

  depends_on = [
    azurerm_private_endpoint.endpoint
  ]
}

locals {
  diagnostics_name               = "${var.name}-acr-diagnostics"
  target_resource_id             = azurerm_container_registry.acr.id
  diagnostics_workspace_provided = var.log_workspace_id != null
}

module "diagnostics" {
  source   = "github.com/ItayMayo/terraform-modules//diagnostic-settings"
  for_each = local.diagnostics_workspace_provided ? { "1" : "1" } : {}

  name                       = local.diagnostics_name
  target_resource_id         = local.target_resource_id
  log_analytics_workspace_id = var.log_workspace_id

  depends_on = [
    azurerm_container_registry.acr
  ]
}
