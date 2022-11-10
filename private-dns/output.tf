output "id" {
  value       = azurerm_private_dns_zone.private_dns.id
  description = "Private DNS resource id."
}

output "name" {
  value       = azurerm_private_dns_zone.private_dns.name
  description = "Private DNS resource name."
}

output "object" {
  value       = azurerm_private_dns_zone.private_dns
  description = "Private DNS resource object."
}
