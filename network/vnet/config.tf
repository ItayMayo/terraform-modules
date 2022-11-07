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

variable "vnet_name" {
  type        = string
  description = "Name of the vnet."
}

variable "address_space" {
  type        = list(string)
  description = "VNet Address Space. Usually has /16 CIDR."
}

variable "dns_servers" {
  default     = null
  type        = list(string)
  description = "Optional. DNS servers to be associated with this Virtual Network.."
}

variable "subnets" {
  type = map(object({
    subnet_name      = string
    address_prefixes = list(string)
    nsg_id           = string
    route_table_id   = string
  }))

  description = "Map of subnets to be associated with this Virtual Network."
}
