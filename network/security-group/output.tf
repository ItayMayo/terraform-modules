output "id" {
  value       = azurerm_network_security_group.nsg.id
  description = "ID of the Security Group resource."
}

output "name" {
  value       = azurerm_network_security_group.nsg.name
  description = "Name of the Security Group resource."
}

output "object" {
  value       = azurerm_network_security_group.nsg
  description = "Object of the Security Group resource."
}
