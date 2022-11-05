resource "azurerm_storage_account" "storage_account" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.resource_location

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

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

module "logger_module" {
  source = "github.com/ItayMayo/terraform-azure-logger"

  name                       = "Diagnostics"
  target_resource_id         = azurerm_storage_account.storage_account.id
  log_analytics_workspace_id = var.log_workspace_id
}
