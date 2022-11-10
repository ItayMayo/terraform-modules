variable "location" {
  type        = string
  description = "Required. Location of the resource."
}

variable "resource_group_name" {
  type        = string
  description = "Required. Name of the parent Resource Group."
}

variable "log_workspace_id" {
  default     = null
  type        = string
  description = "Optional. ID of the log analytics workspace where logs should be sent to."
}

variable "tags" {
  default     = null
  type        = map(string)
  description = "Optional. Tags assigned to the resource."
}

variable "cluster_name" {
  type        = string
  description = "Required. Name of the AKS cluster."
}

variable "dns_prefix" {
  type        = string
  description = "Required. DNS prefix of the AKS cluster."
}

variable "private_cluster_enabled" {
  default     = true
  type        = bool
  description = "Optional. Enable or disable cluster internet access. Default is true."
}

variable "private_dns_zone_id" {
  default     = null
  type        = string
  description = "Optional. ID of the private dns zone associated with the cluster."
}

variable "public_network_access_enabled" {
  default     = false
  type        = bool
  description = "Optional. Enable or disable public network access. Default is false."
}

variable "default_node_pool" {
  type = object({
    name                  = string
    vm_size               = string
    enable_node_public_ip = bool
    enable_auto_scaling   = bool
    node_count            = optional(number)
    os_sku                = optional(string)
    max_count             = optional(number)
    min_count             = optional(number)
    vnet_subnet_id        = optional(string)
  })

  description = "Required. Default node pool block. If auto scaling is enabled, min_count and max_count must be set. Otherwise, node_count must be set."
}

variable "identity" {
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })

  default     = null
  description = "Optional. AKS Identity block."
}

variable "network_profile" {
  type = object({
    network_plugin = string
    network_mode   = optional(string)
    network_policy = optional(string)
  })

  default     = null
  description = "Optional. AKS Network Profile."
}

variable "private_endpoint_subnet_id" {
  default     = null
  type        = string
  description = "Optional. ID of the subnet in which to create a private endpoint for this AKS."
}

variable "create_private_dns" {
  default     = false
  type        = bool
  description = "Optional. Create Private DNS associated with the AKS. Requires Private Endpoint. Default: false."
}

variable "private_dns_vnets" {
  default     = null
  type        = map(string)
  description = "Optional. Map of Virtual Networks to associate with the AKS. Required when create_private_dns is enabled."
}

variable "aks_acr_ids" {
  default     = null
  type        = map(string)
  description = "Optional. Ids of Azure Container Registries to assign to this cluster."
}
