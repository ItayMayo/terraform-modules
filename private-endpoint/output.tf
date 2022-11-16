output "id" {
  value       = azurerm_private_endpoint.endpoint.id
  description = "Private Endpoint resource id."
}

output "name" {
  value       = azurerm_private_endpoint.endpoint.name
  description = "Private Endpoint resource name."
}

output "object" {
  value       = azurerm_private_endpoint.endpoint
  description = "Private Endpoint resource object."
}