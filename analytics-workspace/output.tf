output "workspace_id" {
  value       = azurerm_log_analytics_workspace.analytics_workspace.id
  description = "Analytics Workspace resource id."
}

output "workspace_name" {
  value       = azurerm_log_analytics_workspace.analytics_workspace.name
  description = "Analytics Workspace resource name."
}

output "workspace_object" {
  value       = azurerm_log_analytics_workspace.analytics_workspace
  description = "Analytics Workspace resource object."
}
