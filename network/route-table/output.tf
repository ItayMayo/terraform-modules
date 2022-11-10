output "id" {
  value       = azurerm_route_table.route-table.id
  description = "Route table resource id."
}

output "name" {
  value       = azurerm_route_table.route-table.name
  description = "Route table resource name."
}

output "object" {
  value       = azurerm_route_table.route-table
  description = "Route table resource object."
}
