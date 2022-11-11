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
  for_each = local.create_private_endpoint ? { acr_endpoint = var.private_endpoint_subnet_id } : {}

  name                = local.endpoint_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = each.value

  private_service_connection {
    name                           = local.endpoint_name
    private_connection_resource_id = azurerm_container_registry.acr.id
    is_manual_connection           = local.is_manual_connection
    subresource_names              = local.subresource_names
  }

  tags = var.tags
}

data "azurerm_network_interface" "acr_nic" {
  for_each = local.create_private_endpoint ? { acr = "acr" } : {}

  name                = azurerm_private_endpoint.endpoint["acr_endpoint"].network_interface[0]["name"]
  resource_group_name = var.resource_group_name
}

locals {
  data_record_name   = "${lower(azurerm_container_registry.acr.name)}.${var.location}.data"
  normal_record_name = lower(azurerm_container_registry.acr.name)
  dns_record_ttl     = 3600
  create_dns_zone    = var.private_dns_zone_name != null

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
}

resource "azurerm_private_dns_a_record" "a_record" {
  for_each = local.create_dns_zone ? local.zone_a_records : {}

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
  diagnostics_name   = "acr-diagnostics"
  target_resource_id = azurerm_container_registry.acr.id
}

module "diagnostics" {
  source = "github.com/ItayMayo/terraform-modules//diagnostic-settings"

  name                       = local.diagnostics_name
  target_resource_id         = local.target_resource_id
  log_analytics_workspace_id = var.log_workspace_id

  depends_on = [
    azurerm_container_registry.acr
  ]
}
