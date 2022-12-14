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
  description = "(Required) Name of the Container Registry."
}

variable "sku" {
  type        = string
  description = "(Required) Container Registry SKU name."

  validation {
    condition = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "sku must contain one of the following values: Basic, Standard, Premium."
  }
}

variable "admin_enabled" {
  default     = false
  type        = bool
  description = "(Optional) Enable admin account. Default: false."
}

variable "private_endpoint_subnet_id" {
  type        = string
  description = "(Required) ID of the subnet in which to create a private endpoint for this ACR."
}

variable "private_dns_zone_name" {
  type        = string
  description = "(Required) Name of a Private DNS zone to be associated with the ACR."
}