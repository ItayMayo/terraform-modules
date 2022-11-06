output "subnet_id" {
  value       = azurerm_subnet.subnet.id
  description = "ID of the subnet resource."
}

output "subnet_name" {
  value       = azurerm_subnet.subnet.name
  description = "Name of the subnet resource."
}

output "subnet_object" {
  value       = azurerm_subnet.subnet
  description = "Object of the subnet resource."
}
