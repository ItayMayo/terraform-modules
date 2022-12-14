/**
* # Storage Account Module
*/

locals {
  network_rules_provided = var.network_rules != null
  public_access          = false
}

resource "azurerm_storage_account" "storage_account" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  account_tier             = var.account_tier
  account_kind             = var.account_kind
  account_replication_type = var.replication_type
  allow_nested_items_to_be_public = local.public_access
  public_network_access_enabled   = local.public_access

  dynamic "network_rules" {
    for_each = local.network_rules_provided ? var.network_rules : []

    content {
      default_action             = network_rules.value["default_action"]
      bypass                     = network_rules.value["bypass"]
      virtual_network_subnet_ids = network_rules.value["virtual_network_subnet_ids"]

      dynamic "private_link_access" {
        for_each = network_rules.value["private_link_access"] != null ? [1] : []

        content {
          endpoint_resource_id = network_rules.value["private_link_access"]["endpoint_resource_id"]
          endpoint_tenant_id   = network_rules.value["private_link_access"]["endpoint_tenant_id"]
        }
      }
    }
  }

  tags = var.tags
}

locals {
  endpoint_name        = "${var.name}-private-endpoint"
  is_manual_connection = false
  subresource_names    = ["blob"]
  ip_configuration_name = "internal"
}

resource "azurerm_private_endpoint" "endpoint" {
  name                = local.endpoint_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = local.endpoint_name
    private_connection_resource_id = azurerm_storage_account.storage_account.id
    is_manual_connection           = local.is_manual_connection
    subresource_names              = local.subresource_names
  }

  ip_configuration {
    name               = local.ip_configuration_name
    private_ip_address = var.endpoint_ip_address
    subresource_name   = local.subresource_names[0]
  }

  tags = var.tags

  depends_on = [
    azurerm_storage_account.storage_account
  ]
}

locals {
  dns_record_ttl         = 300
  create_dns_zone_record = var.private_dns_zone_name != null
}

resource "azurerm_private_dns_a_record" "a_record" {
  for_each = local.create_dns_zone_record ? { record = var.private_dns_zone_name } : {}

  name                = var.name
  zone_name           = var.private_dns_zone_name
  resource_group_name = var.resource_group_name
  ttl                 = local.dns_record_ttl
  records             = [var.endpoint_ip_address]

  depends_on = [
    azurerm_private_endpoint.endpoint
  ]
}

locals {
  diagnostics_name               = "${var.name}-storage-account-diagnostics"
  diagnostics_workspace_provided = var.log_workspace_id != null
}

module "diagnostics" {
  source   = "github.com/ItayMayo/terraform-modules//diagnostic-settings"
  for_each = local.diagnostics_workspace_provided ? { "1" : "1" } : {}

  name                       = local.diagnostics_name
  target_resource_id         = azurerm_storage_account.storage_account.id
  log_analytics_workspace_id = var.log_workspace_id

  depends_on = [
    azurerm_storage_account.storage_account
  ]
}
