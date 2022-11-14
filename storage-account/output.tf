output "id" {
  value       = azurerm_storage_account.storage_account.id
  description = "Storage Account resource id."
}

output "name" {
  value       = azurerm_storage_account.storage_account.name
  description = "Storage Account resource name."
}

output "object" {
  value       = azurerm_storage_account.storage_account
  description = "Storage Account resource object."
}

output "endpoint" {
  value = azurerm_private_endpoint.endpoint
  description = "Endpoint object associated with the Storage Account."
}