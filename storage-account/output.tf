output "storage_account_id" {
  value       = azurerm_storage_account.storage_account.id
  description = "Storage Account resource id."
}

output "storage_account_name" {
  value       = azurerm_storage_account.storage_account.name
  description = "Storage Accuont resource name."
}

output "storage_account_object" {
  value       = azurerm_storage_account.storage_account
  description = "Storage Accuont resource object."
}

output "endpoint_object" {
  value       = try(azurerm_private_endpoint.endpoint, null)
  description = "Storage Account Private Endpoint resource object."
}

output "private_dns_object" {
    value       = try(module.storage_account_private_dns["storage_dns"].dns_object, null)
  description = "Storage Account Private DNS resource object."

}