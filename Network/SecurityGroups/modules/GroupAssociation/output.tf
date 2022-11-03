output "association_id" {
  value = azurerm_subnet_network_security_group_association.association.id
}

output "association_object" {
  value = azurerm_subnet_network_security_group_association.association
}
