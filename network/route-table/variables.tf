variable "location" {
  type        = string
  description = "Required. Location of the resource."
}

variable "resource_group_name" {
  type        = string
  description = "Required. Name of the parent Resource Group."
}

variable "tags" {
  default     = null
  type        = map(string)
  description = "Optional. Tags assigned to the resource."
}

variable "table_name" {
  type        = string
  description = "Required. Route table name."
}

variable "disable_bgp_route_propagation" {
  default     = false
  type        = bool
  description = "Optional. Disable route table bgp route propagation. Default: false."
}

variable "table_routes" {
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))

  description = "Required. Route table routes."
}
