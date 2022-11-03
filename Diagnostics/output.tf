output "logger_id" {
  value = azurerm_monitor_diagnostic_setting.diagnostics.id
}

output "logger_object" {
  value = azurerm_monitor_diagnostic_setting.diagnostics
}
