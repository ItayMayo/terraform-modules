resource "azurerm_log_analytics_workspace" "analytics_workspace" {
  name                       = var.name
  resource_group_name        = var.resource_group_name
  location                   = var.resource_location
  sku                        = var.sku
  retention_in_days          = var.retention_in_days
  daily_quota_gb             = var.daily_quota_gb
  internet_query_enabled     = var.internet_query_enabled
  internet_ingestion_enabled = var.internet_ingestion_enabled

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}
