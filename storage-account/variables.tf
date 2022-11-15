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
  description = "(Required) Tags assigned to the resource."
}

variable "name" {
  type        = string
  description = "(Required) Storage Accuont name."
}

variable "account_tier" {
  default     = "Standard"
  type        = string
  description = "(Required) Storage Accuont tier. Default: Standard."
}

variable "account_kind" {
  default     = "StorageV2"
  type        = string
  description = "(Required) Storage Account kind. Default: StorageV2."
}

variable "replication_type" {
  default     = "LRS"
  type        = string
  description = "(Required) Storage Account replication type. Default: LRS."
}

variable "network_rules" {
  default = null

  type = list(object({
    default_action             = string
    bypass                     = list(string)
    virtual_network_subnet_ids = list(string)

    private_link_access = object({
      endpoint_resource_id = string
      endpoint_tenant_id   = string
    })
  }))

  description = "(Optional) Storage Account Network Rules."
}

variable "private_endpoint_subnet_id" {
  type        = string
  description = "(Required) ID of the subnet in which to create a private endpoint for this Storage Account."
}

variable "private_dns_zone_name" {
  default     = null
  type        = string
  description = "(Optional) Name of a Private DNS zone to be associated with the storage account."
}

variable "endpoint_ip_address" {
  type = string
  description = "(Required) Private IP Address to associate with this Storage Account's private endpoint."
}