output "vnet_id" {
  value       = azurerm_virtual_network.vnet.id
  description = "ID of the Virtual Network resource."
}

output "vnet_name" {
  value       = azurerm_virtual_network.vnet.name
  description = "Name of the Virtual Network resource."
}

output "vnet_object" {
  value       = azurerm_virtual_network.vnet
  description = "Object of the Virtual Network resource."
}

output "subnet_ids" {
  value       = { for subnet in module.subnets : subnet.subnet_name => subnet.subnet_id }
}

output "subnet_objects" {
  value       = module.subnets
  description = "Objects of the Subnet resources associated with the Virtual Network resource."
}
