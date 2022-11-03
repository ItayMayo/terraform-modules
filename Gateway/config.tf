variable "gateway_name" {
  type = string
}

variable "gateway_type" {
  type = string
}

variable "gateway_vpn_type" {
  type = string
}

variable "enable_active_active" {
  default = false
  type    = bool
}

variable "enable_bgp" {
  default = false
  type    = bool
}

variable "gateway_sku" {
  type = string
}

variable "gateway_sku_generation" {
  type = string
}

variable "ip_configuration" {
  type = list(object({
    name                          = string
    public_ip_address_id          = string
    private_ip_address_allocation = string
    subnet_id                     = string
  }))
}

variable "enable_point_to_site" {
  default = false
  type    = bool
}

variable "vpn_client_configuration" {
  default = null

  type = object({
    address_space         = list(string)
    auth_types            = list(string)
    client_protocols      = list(string)
    radius_server_address = string
    radius_server_secret  = string

    root_certificate = object({
      name             = string
      public_cert_data = string
    })

    revoked_certificate = object({
      name       = string
      thumbprint = string
    })
  })
}

variable "bgp_settings" {
  default = null

  type = object({
    asn         = string
    peer_weight = string

    peering_addresses = object({
      ip_configuration_name = string
      apipa_addresses       = list(string)
    })
  })
}
