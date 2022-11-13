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

variable "name" {
  type        = string
  description = "Required. Name of the Container Registry."
}

variable "sku" {
  type        = string
  description = "Required. Container Registry SKU name."
}

variable "admin_enabled" {
  default     = false
  type        = bool
  description = "Optional. Enable admin account. Default: false."
}

variable "data_endpoint_enabled" {
  default     = false
  type        = bool
  description = "Required. Enable ACR Data Endpoint. Default: false."
}

variable "private_endpoint_subnet_id" {
  default     = null
  type        = string
  description = "Optional. ID of the subnet in which to create a private endpoint for this ACR."
}

variable "private_dns_zone_name" {
  default     = null
  type        = string
  description = "Optional. Name of a Private DNS zone to be associated with the ACR."
}