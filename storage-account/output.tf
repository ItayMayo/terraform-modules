output "id" {
  value       = azurerm_storage_account.storage_account.id
  description = "Storage Account resource id."
}

output "name" {
  value       = azurerm_storage_account.storage_account.name
  description = "Storage Accuont resource name."
}

output "object" {
  value       = azurerm_storage_account.storage_account
  description = "Storage Accuont resource object."
}

output "endpoint_object" {
  value       = try(azurerm_private_endpoint.endpoint["storage_endpoint"], null)
  description = "Storage Account Private Endpoint resource object."
}