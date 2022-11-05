output "dns_id" {
  value = azurerm_private_dns_zone.private_dns.id
}

output "dns_name" {
  value = azurerm_private_dns_zone.private_dns.name
}

output "dns_object" {
  value = azurerm_private_dns_zone.private_dns
}
