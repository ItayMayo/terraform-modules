output "id" {
  value       = azurerm_subnet.subnet.id
  description = "ID of the subnet resource."
}

output "name" {
  value       = azurerm_subnet.subnet.name
  description = "Name of the subnet resource."
}

output "object" {
  value       = azurerm_subnet.subnet
  description = "Object of the subnet resource."
}