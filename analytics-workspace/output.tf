output "id" {
  value       = azurerm_log_analytics_workspace.analytics_workspace.id
  description = "Analytics Workspace resource id."
}

output "name" {
  value       = azurerm_log_analytics_workspace.analytics_workspace.name
  description = "Analytics Workspace resource name."
}

output "object" {
  value       = azurerm_log_analytics_workspace.analytics_workspace
  description = "Analytics Workspace resource object."
}
