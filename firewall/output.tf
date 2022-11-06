output "firewall_id" {
  value       = azurerm_firewall.firewall.id
  description = "ID of the Firewall resource."
}

output "firewall_name" {
  value       = azurerm_firewall.firewall.name
  description = "Name of the Firewall resource."
}

output "firewall_object" {
  value       = azurerm_firewall.firewall
  description = "Object of the Firewall resource."
}
