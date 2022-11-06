output "cluster_id" {
  value       = azurerm_kubernetes_cluster.cluster.id
  description = "AKS cluster resource id."
}

output "cluster_name" {
  value       = azurerm_kubernetes_cluster.cluster.name
  description = "AKS cluster resource name."
}

output "cluster_object" {
  value       = azurerm_kubernetes_cluster.cluster
  description = "AKS cluster resource object."
}

output "client_certificate" {
  value       = azurerm_kubernetes_cluster.cluster.kube_config.0.client_certificate
  sensitive   = true
  description = "AKS cluster resource client certificate."
}

output "kube_config" {
  value       = azurerm_kubernetes_cluster.cluster.kube_config_raw
  sensitive   = true
  description = "AKS cluster resource kube config."
}

output "endpoint_object" {
  value       = try(azurerm_private_endpoint.endpoint, null)
  description = "AKS Private Endpoint resource object."
}

output "private_dns_object" {
  value       = try(module.aks-private-dns["aks_dns"].dns_object, null)
  description = "AKS Private DNS resource object."
}
