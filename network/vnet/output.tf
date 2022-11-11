output "id" {
  value       = azurerm_virtual_network.vnet.id
  description = "ID of the Virtual Network resource."
}

output "name" {
  value       = azurerm_virtual_network.vnet.name
  description = "Name of the Virtual Network resource."
}

output "object" {
  value       = azurerm_virtual_network.vnet
  description = "Object of the Virtual Network resource."
}

output "subnet_ids" {
  value       = { for subnet in module.subnets : subnet.name => subnet.id }
  description = "List of subnet resource ids associated with the Virtual Network resource."
}

output "subnet_objects" {
  value       = module.subnets
  description = "Objects of the Subnet resources associated with the Virtual Network resource."
}
