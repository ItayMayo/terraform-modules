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
    associate_nsg    = bool
  }))

  description = "Map of subnets to be associated with this Virtual Network."
}

variable "nsg_id" {
  default     = null
  type        = string
  description = "Optional. ID of the Network Security Group to associate with the subnets. Required when associate_nsg is set to true for at least one subnet."
}
