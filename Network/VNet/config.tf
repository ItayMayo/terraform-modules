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
  type = list(object({
    subnet_name      = string
    address_prefixes = list(string)
  }))

  description = "List of subnets to be associated with this Virtual Network."
}
