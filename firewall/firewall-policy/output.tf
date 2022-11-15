output "id" {
  value       = azurerm_firewall_policy.firewall_policy.id
  description = "Firewall Policy id."
}

output "name" {
  value       = azurerm_firewall_policy.firewall_policy.name
  description = "Firewall Policy name."
}

output "object" {
  value       = azurerm_firewall_policy.firewall_policy
  description = "Firewall Policy object."
}
