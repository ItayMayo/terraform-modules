output "dns_id" {
  value       = azurerm_private_dns_zone.private_dns.id
  description = "Private DNS resource id."
}

output "dns_name" {
  value       = azurerm_private_dns_zone.private_dns.name
  description = "Private DNS resource name."
}

output "dns_object" {
  value       = azurerm_private_dns_zone.private_dns
  description = "Private DNS resource object."
}
