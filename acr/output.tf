output "acr_id" {
  value       = azurerm_container_registry.acr.id
  description = "ACR resource id."
}

output "acr_name" {
  value       = azurerm_container_registry.acr.name
  description = "ACR resource name."
}

output "acr_object" {
  value       = azurerm_container_registry.acr
  description = "ACR resource object."
}

output "endpoint_object" {
  value       = try(azurerm_private_endpoint.endpoint["acr_endpoint"], null)
  description = "Storage Account Private Endpoint resource object."
}

output "private_dns_object" {
  value       = try(module.acr-private-dns["acr_dns"].dns_object, null)
  description = "Storage Account Private DNS resource object."

}
