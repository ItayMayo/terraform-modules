output "id" {
  value       = azurerm_virtual_network_gateway.vng.id
  description = "ID of the VNG resource."
}

output "name" {
  value       = azurerm_virtual_network_gateway.vng.name
  description = "Name of the VNG resource."
}

output "object" {
  value       = azurerm_virtual_network_gateway.vng
  description = "Object of the VNG resource."
}
