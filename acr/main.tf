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
  endpoint_name     = "${var.name}-private-endpoint"
  subresource_names = ["registry"]
}

module "private-endpoint" {
  source = "github.com/ItayMayo/terraform-modules//private-endpoint"

  name                       = local.endpoint_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  private_endpoint_subnet_id = var.private_endpoint_subnet_id
  subresource_names          = local.subresource_names
  target_resource_id         = azurerm_container_registry.acr.id
  tags                       = var.tags

  depends_on = [
    azurerm_container_registry.acr
  ]
}

locals {
  normal_record_name = lower(var.name)
  dns_record_ttl     = 3600

  zone_a_records = {
    name    = local.normal_record_name
    ttl     = local.dns_record_ttl
    records = [module.private-endpoint.object.private_service_connection[0].private_ip_address]
  }

}

resource "azurerm_private_dns_a_record" "a_record" {
  name                = local.zone_a_records["name"]
  zone_name           = var.private_dns_zone_name
  resource_group_name = var.resource_group_name
  ttl                 = local.zone_a_records["ttl"]
  records             = local.zone_a_records["records"]

  depends_on = [
    module.private-endpoint
  ]
}

locals {
  diagnostics_name               = "${var.name}-acr-diagnostics"
  diagnostics_workspace_provided = var.log_workspace_id != null
}

module "diagnostics" {
  source   = "github.com/ItayMayo/terraform-modules//diagnostic-settings"
  
  count = local.diagnostics_workspace_provided ? 1 : 0

  name                       = local.diagnostics_name
  target_resource_id         = azurerm_container_registry.acr.id
  log_analytics_workspace_id = var.log_workspace_id

  depends_on = [
    azurerm_container_registry.acr
  ]
}
