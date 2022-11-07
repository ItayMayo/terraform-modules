locals {
  network_rules_provided = var.network_rules != null
}

resource "azurerm_storage_account" "storage_account" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  account_tier             = var.account_tier
  account_kind             = var.account_kind
  account_replication_type = var.replication_type

  allow_nested_items_to_be_public = var.allow_nested_items_to_be_public
  public_network_access_enabled   = var.public_network_access_enabled

  dynamic "network_rules" {
    for_each = local.network_rules_provided ? var.network_rules : []

    content {
      default_action             = network_rules.value["default_action"]
      bypass                     = network_rules.value["bypass"]
      ip_rules                   = network_rules.value["ip_rules"]
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
}

locals {
  create_private_endpoint = var.private_endpoint_subnet_id != null
  endpoint_name           = "${azurerm_storage_account.storage_account.name}-private-endpoint"
  is_manual_connection    = false
  subresource_names       = ["blob"]
}

resource "azurerm_private_endpoint" "endpoint" {
  for_each = local.create_private_endpoint ? { storage_endpoint = var.private_endpoint_subnet_id } : {}

  name                = local.endpoint_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = each.value
  tags                = var.tags

  private_service_connection {
    name                           = local.endpoint_name
    private_connection_resource_id = azurerm_storage_account.storage_account.id
    is_manual_connection           = local.is_manual_connection
    subresource_names              = local.subresource_names
  }
}

locals {
  dns_record_ttl = 300
}

module "storage-account-private-dns" {
  source = "github.com/ItayMayo/terraform-modules//private-dns"

  for_each = var.create_private_dns ? { storage_dns = "storage_dns" } : {}

  resource_group_name = var.resource_group_name

  zone_name = var.private_dns_zone_name
  vnet_ids  = var.private_dns_vnets
  tags      = var.tags

  zone_a_records = {
    storage_account = {
      name    = azurerm_storage_account.storage_account.name
      ttl     = local.dns_record_ttl
      records = [azurerm_private_endpoint.endpoint["storage_endpoint"].private_service_connection["private_ip_address"]]
    }
  }

  depends_on = [
    azurerm_private_endpoint.endpoint
  ]
}

locals {
  diagnostics_name   = "Diagnostics"
  target_resource_id = azurerm_storage_account.storage_account.id
}

module "diagnostics" {
  source = "github.com/ItayMayo/terraform-modules//diagnostic-settings"

  name                       = local.diagnostics_name
  target_resource_id         = local.target_resource_id
  log_analytics_workspace_id = var.log_workspace_id
}
