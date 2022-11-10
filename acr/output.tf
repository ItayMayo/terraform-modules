output "id" {
  value       = azurerm_container_registry.acr.id
  description = "ACR resource id."
}

output "name" {
  value       = azurerm_container_registry.acr.name
  description = "ACR resource name."
}

output "object" {
  value       = azurerm_container_registry.acr
  description = "ACR resource object."
}

output "endpoint_object" {
  value       = try(azurerm_private_endpoint.endpoint["acr_endpoint"], null)
  description = "Storage Account Private Endpoint resource object."
}