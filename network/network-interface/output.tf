output "id" {
  value       = azurerm_network_interface.nic.id
  description = "ID of the network interface resource."
}

output "name" {
  value       = azurerm_network_interface.nic.name
  description = "Name of the network interface resource."
}

output "object" {
  value       = azurerm_network_interface.nic
  description = "Object of the network interface resource."
}
