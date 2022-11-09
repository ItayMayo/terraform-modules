output "id" {
  value       = azurerm_route_table.udrt.id
  description = "Route table resource id."
}

output "name" {
  value       = azurerm_route_table.udrt.name
  description = "Route table resource name."
}

output "object" {
  value       = azurerm_route_table.udrt
  description = "Route table resource object."
}
