output "origin_peering_id" {
  value       = azurerm_virtual_network_peering.peering_origin_target.id
  description = "ID of the origin's peering resource."
}

output "origin_peering_name" {
  value       = azurerm_virtual_network_peering.peering_origin_target.name
  description = "Name of the origin's peering resource."
}

output "origin_peering_object" {
  value       = azurerm_virtual_network_peering.peering_origin_target
  description = "Object of the origin's peering resource."
}

output "target_peering_id" {
  value       = azurerm_virtual_network_peering.peering_target_origin.id
  description = "ID of the target's peering resource."
}

output "target_peering_name" {
  value       = azurerm_virtual_network_peering.peering_target_origin.name
  description = "Name of the target's peering resource."
}

output "target_peering_object" {
  value       = azurerm_virtual_network_peering.peering_target_origin
  description = "Object of the target's peering resource."
}
