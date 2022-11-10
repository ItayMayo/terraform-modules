output "id" {
  value       = azurerm_monitor_diagnostic_setting.diagnostics.id
  description = "ID of the diagnostic_settings resource."
}

output "object" {
  value       = azurerm_monitor_diagnostic_setting.diagnostics
  description = "Object of the diagnostic_settings resource."
}
