output "object" {
  value = data.azurerm_monitor_diagnostic_categories.diagnostic_categories
}

output "diagnostic_category_types" {
  value = try(data.azurerm_monitor_diagnostic_categories.diagnostic_categories.log_category_types, [])
}

output "diagnostic_category_groups" {
  value = try(data.azurerm_monitor_diagnostic_categories.diagnostic_categories.log_category_groups, [])
}

output "diagnostic_metrics_categories" {
  value = try(data.azurerm_monitor_diagnostic_categories.diagnostic_categories.metrics, [])
}
