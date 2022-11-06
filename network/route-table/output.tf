output "table_id" {
  value       = azurerm_route_table.udrt.id
  description = "Route table resource id."
}

output "table_name" {
  value       = azurerm_route_table.udrt.name
  description = "Route table resource name."
}

output "table_object" {
  value       = azurerm_route_table.udrt
  description = "Route table resource object."
}
