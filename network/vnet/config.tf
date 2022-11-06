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
