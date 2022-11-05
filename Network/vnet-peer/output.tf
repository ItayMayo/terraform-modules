output "origin_peering_id" {
  value       = azurerm_virtual_network_peering.peering_1_2.id
  description = "ID of the origin's peering resource."
}

output "origin_peering_name" {
  value       = azurerm_virtual_network_peering.peering_1_2.name
  description = "Name of the origin's peering resource."
}

output "origin_peering_object" {
  value       = azurerm_virtual_network_peering.peering_1_2
  description = "Object of the origin's peering resource."
}

output "target_peering_id" {
  value       = azurerm_virtual_network_peering.peering_1_2.id
  description = "ID of the target's peering resource."
}

output "target_peering_name" {
  value       = azurerm_virtual_network_peering.peering_1_2.name
  description = "Name of the target's peering resource."
}

output "target_peering_object" {
  value       = azurerm_virtual_network_peering.peering_1_2
  description = "Object of the target's peering resource."
}
