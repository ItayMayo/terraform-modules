output "collection_id" {
  value = azurerm_firewall_policy_rule_collection_group.firewall_policy_collection_group.id
}

output "collection_name" {
  value = azurerm_firewall_policy_rule_collection_group.firewall_policy_collection_group.name
}

output "collection_object" {
  value = azurerm_firewall_policy_rule_collection_group.firewall_policy_collection_group
}
