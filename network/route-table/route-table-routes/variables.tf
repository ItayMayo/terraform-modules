variable "resource_group_name" {
  type        = string
  description = "(Required) Name of the parent Resource Group."
}

variable "route_table_name" {
  type        = string
  description = "(Required) Name of the Route Table to assign the Routes to."
}

variable "route_table_routes" {
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))

  description = "(Required) Routes to assign to the route table."
}
