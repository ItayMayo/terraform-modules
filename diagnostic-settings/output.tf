output "name" {
  value       = azurerm_monitor_diagnostic_setting.diagnostics.name
  description = "Name of the diagnostic_settings resource."
}

output "id" {
  value       = azurerm_monitor_diagnostic_setting.diagnostics.id
  description = "ID of the diagnostic_settings resource."
}

output "object" {
  value       = azurerm_monitor_diagnostic_setting.diagnostics
  description = "Object of the diagnostic_settings resource."
}
