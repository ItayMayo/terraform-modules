output "firewall_id" {
  value = azurerm_firewall.firewall.id
}

output "firewall_name" {
  value = azurerm_firewall.firewall.name
}

output "firewall_object" {
  value = azurerm_firewall.firewall
}

output "firewall_policy_id" {
  value = azurerm_firewall_policy.firewall_policy.id
}

output "firewall_policy_name" {
  value = azurerm_firewall_policy.firewall_policy.name
}

output "firewall_policy_object" {
  value = azurerm_firewall_policy.firewall_policy
}
