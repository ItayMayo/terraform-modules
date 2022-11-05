module "log_categories_module" {
  source = "./modules/LogCategories"

  for_each = local.subscription_id_provided ? {} : {
    resource = var.target_resource_id
  }

  resource_id = each.value
}

resource "azurerm_monitor_diagnostic_setting" "diagnostics" {
  name               = var.name
  target_resource_id = local.subscription_id_provided ? var.subscription_id : var.target_resource_id

  storage_account_id             = var.storage_account_id
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  eventhub_name                  = var.eventhub_name
  eventhub_authorization_rule_id = var.eventhub_authorization_rule_id

  dynamic "log" {
    for_each = local.subscription_id_provided || local.does_resource_contain_category_groups ? [] : module.log_categories_module["resource"].diagnostic_category_types

    content {
      category = log.value
      enabled  = true

      dynamic "retention_policy" {
        for_each = var.retention_policy != null ? [var.retention_policy] : []

        content {
          days    = retention_policy.value["days"]
          enabled = retention_policy.value["enabled"]
        }
      }
    }
  }

  dynamic "log" {
    for_each = local.subscription_id_provided ? [] : module.log_categories_module["resource"].diagnostic_category_groups

    content {
      category_group = log.value
      enabled        = true

      dynamic "retention_policy" {
        for_each = var.retention_policy != null ? [var.retention_policy] : []

        content {
          days    = retention_policy.value["days"]
          enabled = retention_policy.value["enabled"]
        }
      }
    }
  }

  dynamic "log" {
    for_each = local.subscription_id_provided ? local.subscription_log_category_groups : []

    content {
      category = log.value
      enabled  = true

      dynamic "retention_policy" {
        for_each = var.retention_policy != null ? [var.retention_policy] : []

        content {
          days    = retention_policy.value["days"]
          enabled = retention_policy.value["enabled"]
        }
      }
    }
  }

  dynamic "metric" {
    for_each = local.subscription_id_provided ? [] : module.log_categories_module["resource"].diagnostic_metrics_categories

    content {
      category = metric.value

      dynamic "retention_policy" {
        for_each = var.retention_policy != null ? [var.retention_policy] : []

        content {
          days    = retention_policy.value["days"]
          enabled = retention_policy.value["enabled"]
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [
      log_analytics_destination_type,
    ]
  }
}
