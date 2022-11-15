variable "location" {
  type        = string
  description = "(Required) Location of the resource."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Name of the parent Resource Group."
}

variable "log_workspace_id" {
  type        = string
  description = "(Required) ID of the log analytics workspace where logs should be sent to. Set as null if not needed."
}

variable "tags" {
  default     = null
  type        = map(string)
  description = "(Optional) Tags assigned to the resource."
}

variable "name" {
  type        = string
  description = "(Required) Name of the AKS cluster."
}

variable "aks_dns_prefix" {
  type        = string
  description = "(Required) DNS prefix of the AKS cluster."
}

variable "aks_private_dns_zone_id" {
  default     = null
  type        = string
  description = "(Optional) ID of the private dns zone associated with the cluster."
}

variable "default_node_pool" {
  type = object({
    name                = string
    vm_size             = string
    enable_auto_scaling = optional(bool)
    node_count          = optional(number)
    os_sku              = optional(string)
    max_count           = optional(number)
    min_count           = optional(number)
    vnet_subnet_id      = optional(string)
  })

  description = "(Required) Default node pool block. If auto scaling is enabled, min_count and max_count must be set. Otherwise, node_count must be set."
}

variable "identity" {
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })

  default     = {
    type = "SystemAssigned"
  }
  description = "(Optional) AKS Identity block. Default: SystemAssigned."
}

variable "network_profile" {
  type = object({
    network_plugin = string
    network_mode   = optional(string)
    network_policy = optional(string)
  })

  default     = null
  description = "(Optional) AKS Network Profile."
}

variable "private_endpoint_subnet_id" {
  type        = string
  description = "(Required) ID of the subnet in which to create a private endpoint for this AKS."
}

variable "private_dns_vnets" {
  type        = map(string)
  description = "(Required) Map of Virtual Networks to associate with the AKS. Required when create_private_dns is enabled."
}

variable "aks_acr_ids" {
  default     = null
  type        = map(string)
  description = "(Optional) Ids of Azure Container Registries to assign to this cluster."
}