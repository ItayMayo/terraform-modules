variable "location" {
  type        = string
  description = "Location of the resource."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the parent Resource Group."
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "Tags assigned to the resource."
}

variable "table_name" {
  type        = string
  description = "Route table name."
}

variable "disable_bgp_route_propagation" {
  default     = false
  type        = bool
  description = "Disable route table bgp route propagation. Default: false."
}

variable "table_routes" {
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = string
  }))

  description = "Route table routes."
}
