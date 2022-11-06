locals {
  subscription_id_provided = var.subscription_id != null
}

module "log-categories" {
  source = "./log-categories"

  for_each = local.subscription_id_provided ? {} : {
    resource = var.target_resource_id
  }

  resource_id = each.value
}

locals {
  does_resource_contain_category_groups = try(module.log-categories["resource"].diagnostic_category_groups, []) != []
  logs_enabled                          = true
  enable_retention_policy               = var.retention_policy_days != null

  subscription_log_category_groups = [
    "Administrative",
    "Security",
    "ServiceHealth",
    "Alert",
    "Recommendation",
    "Policy",
    "Autoscale",
  ]
}


resource "azurerm_monitor_diagnostic_setting" "diagnostics" {
  name               = var.name
  target_resource_id = local.subscription_id_provided ? var.subscription_id : var.target_resource_id

  storage_account_id             = var.storage_account_id
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  eventhub_name                  = var.eventhub_name
  eventhub_authorization_rule_id = var.eventhub_authorization_rule_id

  dynamic "log" {
    for_each = local.subscription_id_provided || local.does_resource_contain_category_groups ? [] : module.log-categories["resource"].diagnostic_category_types

    content {
      category = log.value
      enabled  = local.logs_enabled

      dynamic "retention_policy" {
        for_each = local.enable_retention_policy ? [1] : []

        content {
          days    = var.retention_policy_days
          enabled = local.logs_enabled
        }
      }
    }
  }

  dynamic "log" {
    for_each = local.subscription_id_provided ? [] : module.log-categories["resource"].diagnostic_category_groups

    content {
      category_group = log.value
      enabled        = local.logs_enabled

      dynamic "retention_policy" {
        for_each = local.enable_retention_policy ? [1] : []

        content {
          days    = var.retention_policy_days
          enabled = local.logs_enabled
        }
      }
    }
  }

  dynamic "log" {
    for_each = local.subscription_id_provided ? local.subscription_log_category_groups : []

    content {
      category = log.value
      enabled  = local.logs_enabled

      dynamic "retention_policy" {
        for_each = local.enable_retention_policy ? [1] : []

        content {
          days    = var.retention_policy_days
          enabled = local.logs_enabled
        }
      }
    }
  }

  dynamic "metric" {
    for_each = local.subscription_id_provided ? [] : module.log-categories["resource"].diagnostic_metrics_categories

    content {
      category = metric.value

      dynamic "retention_policy" {
        for_each = local.enable_retention_policy ? [1] : []

        content {
          days    = var.retention_policy_days
          enabled = local.logs_enabled
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
