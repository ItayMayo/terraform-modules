output "id" {
  value       = azurerm_network_interface.network_interface.id
  description = "ID of the network interface resource."
}

output "name" {
  value       = azurerm_network_interface.network_interface.name
  description = "Name of the network interface resource."
}

output "object" {
  value       = azurerm_network_interface.network_interface
  description = "Object of the network interface resource."
}
