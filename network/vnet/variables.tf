variable "location" {
  type        = string
  description = "(Required) Location of the resource."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Name of the parent Resource Group."
}

variable "log_workspace_id" {
  default     = null
  type        = string
  description = "(Optional) ID of the log analytics workspace where logs should be sent to."
}

variable "tags" {
  default     = null
  type        = map(string)
  description = "(Optional) Tags assigned to the resource."
}

variable "vnet_name" {
  type        = string
  description = "(Required) Name of the vnet."
}

variable "address_space" {
  type        = list(string)
  description = "(Required) VNet Address Space. Usually has /16 CIDR."
}

variable "dns_servers" {
  default     = null
  type        = list(string)
  description = "(Optional) DNS servers to be associated with this Virtual Network.."
}

variable "subnets" {
  type = map(object({
    subnet_name      = string
    address_prefixes = list(string)
    nsg_id           = optional(string)
    route_table_id   = optional(string)
  }))

  description = "(Required) Map of subnets to be associated with this Virtual Network."
}
