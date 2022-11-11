output "id" {
  value       = azurerm_virtual_network_gateway.virtual_network_gateway.id
  description = "ID of the VNG resource."
}

output "name" {
  value       = azurerm_virtual_network_gateway.virtual_network_gateway.name
  description = "Name of the VNG resource."
}

output "object" {
  value       = azurerm_virtual_network_gateway.virtual_network_gateway
  description = "Object of the VNG resource."
}
