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

variable "acr_name" {
  type        = string
  description = "Name of the Container Registry."
}

variable "acr_sku" {
  type        = string
  description = "Container Registry SKU name."
}

variable "admin_enabled" {
  default     = false
  type        = bool
  description = "Enable admin account."
}

variable "public_network_access_enabled" {
  default     = true
  type        = bool
  description = "Enable ACR public network access."
}

variable "data_endpoint_enabled" {
  default     = false
  type        = bool
  description = "Enable ACR Data Endpoint."
}

variable "private_endpoint_subnet_id" {
  default     = null
  type        = string
  description = "Optional. ID of the subnet in which to create a private endpoint for this ACR."
}

variable "create_private_dns" {
  default     = false
  type        = bool
  description = "Optional. Create Private DNS associated with the ACR. Requires Private Endpoint. Default: false."
}

variable "private_dns_zone_name" {
  default     = "privatelink.azurecr.io"
  type        = string
  description = "Optional. Name of a Private DNS zone to be associated with the ACR. Default: privatelink.azurecr.io."
}

variable "private_dns_vnets" {
  default     = null
  type        = map(string)
  description = "Map of Virtual Networks to associate with the private dns. Required when create_private_dns is enabled."
}
