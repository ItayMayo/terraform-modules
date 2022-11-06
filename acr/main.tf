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
  create_private_endpoint = var.private_endpoint_subnet_id != null
  endpoint_name           = "${azurerm_container_registry.acr.name}-private-endpoint"
  is_manual_connection    = false
  subresource_names       = ["registry"]
}

resource "azurerm_private_endpoint" "endpoint" {
  for_each = local.create_private_endpoint ? [var.private_endpoint_subnet_id] : []

  name                = local.endpoint_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = each.value["private_endpoint_subnet_id"]
  tags                = var.tags

  private_service_connection {
    name                           = local.endpoint_name
    private_connection_resource_id = azurerm_container_registry.acr.id
    is_manual_connection           = local.is_manual_connection
    subresource_names              = local.subresource_names
  }
}

locals {
  data_record_name   = "${lower(azurerm_container_registry.acr.name)}.${var.location}.data"
  normal_record_name = lower(azurerm_container_registry.acr.name)
  dns_record_ttl     = 3600
}

module "storage_account_private_dns" {
  source = "github.com/ItayMayo/terraform-modules//private-dns"

  for_each = var.create_private_dns ? { acr_dns = "acr_dns" } : {}

  zone_name = var.private_dns_zone_name
  vnet_ids  = var.private_dns_vnets
  tags      = var.tags

  zone_a_records = {
    acr_data_record = {
      name    = local.data_record_name
      ttl     = local.dns_record_ttl
      records = [data.azurerm_network_interface.acr_nic["acr"].private_ip_addresses[0]]
    },
    acr_normal_record = {
      name    = local.normal_record_name
      ttl     = local.dns_record_ttl
      records = [data.azurerm_network_interface.acr_nic["acr"].private_ip_addresses[1]]
    }

  }

  depends_on = [
    azurerm_private_endpoint.endpoint
  ]
}

locals {
  diagnostics_name = "ACR Diagnostics"
  resource_id      = azurerm_container_registry.acr.id
}

module "diagnostics_module" {
  source = "github.com/ItayMayo/terraform-modules//diagnostic-settings"

  name                       = local.diagnostics_name
  target_resource_id         = local.resource_id
  log_analytics_workspace_id = var.log_workspace_id
}