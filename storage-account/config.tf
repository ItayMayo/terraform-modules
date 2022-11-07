variable "location" {
  type        = string
  description = "Location of the resource."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the parent Resource Group."
}

variable "log_workspace_id" {
  default     = null
  type        = string
  description = "ID of the log analytics workspace where logs should be sent to."
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "Tags assigned to the resource."
}

variable "name" {
  type        = string
  description = "Storage Accuont name."
}

variable "account_tier" {
  default     = "Standard"
  type        = string
  description = "Storage Accuont tier. Default: Standard."
}

variable "account_kind" {
  default     = "StorageV2"
  type        = string
  description = "Storage Account kind. Default: StorageV2."
}

variable "replication_type" {
  default     = "GRS"
  type        = string
  description = "Storage Account replication type. Default: GRS."
}

variable "allow_nested_items_to_be_public" {
  default     = false
  type        = bool
  description = "Allow Storage Account nested items to be accessible over the public network. Default: false."
}

variable "public_network_access_enabled" {
  default     = false
  type        = bool
  description = "Enable Storage Account public network access. Default: false."
}

variable "network_rules" {
  default = null

  type = list(object({
    default_action             = string
    bypass                     = list(string)
    ip_rules                   = list(string)
    virtual_network_subnet_ids = list(string)

    private_link_access = object({
      endpoint_resource_id = string
      endpoint_tenant_id   = string
    })
  }))

  description = "Optional. Storage Account Network Rules."
}

variable "private_endpoint_subnet_id" {
  default     = null
  type        = string
  description = "Optional. ID of the subnet in which to create a private endpoint for this Storage Account."
}

variable "create_private_dns" {
  default     = false
  type        = bool
  description = "Optional. Create Private DNS associated with the Storage Account. Requires Private Endpoint. Default: false."
}

variable "private_dns_zone_name" {
  default     = "privatelink.azurestorage.io"
  type        = string
  description = "Optional. Name of a Private DNS zone to be associated with the storage account. Default: privatelink.azurestorage.io."
}

variable "private_dns_vnets" {
  default     = null
  type        = map(string)
  description = "Map of Virtual Networks to associate with the private dns. Required when create_private_dns is enabled."
}
