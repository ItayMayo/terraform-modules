variable "table_name" {
  type = string
}

variable "disable_bgp_route_propagation" {
  type = bool
}

variable "table_routes" {
  type = list(map(any))
}
