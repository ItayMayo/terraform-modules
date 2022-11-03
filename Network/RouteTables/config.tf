variable "route_tables" {
  default = {
    udrt = {
      table_name                    = null
      disable_bgp_route_propagation = null
      table_routes                  = null
    }
  }

  type = map(any)
}

variable "table_association" {
  default = {
    udrt-association = {
      subnet_id  = null
      table_name = null
    }
  }

  type = map(any)
}
