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

variable "gateway_name" {
  type        = string
  description = "Name of the Gateway resource."
}

variable "gateway_type" {
  default     = "Vpn"
  type        = string
  description = "Type of the Gateway Resource. Default: Vpn."
}

variable "gateway_vpn_type" {
  default     = "RouteBased"
  type        = string
  description = "Type of the Gateway VPN. Default: RouteBased."
}

variable "enable_active_active" {
  default     = true
  type        = bool
  description = "Enable Gateway Active-Active. Default: true."
}

variable "enable_bgp" {
  default     = false
  type        = bool
  description = "Enable Gateway BGP. Default: false."
}

variable "gateway_sku" {
  default     = "VpnGw2AZ"
  type        = string
  description = "SKU of the Gateway. Default: VpnGw2AZ."
}

variable "gateway_sku_generation" {
  default     = "Generation2"
  type        = string
  description = "Generation of the Gateway SKU. Default: Generation2."
}

variable "gateway_subnet_id" {
  type        = string
  description = "ID of the Gateway Subnet."
}

variable "enable_point_to_site" {
  default     = false
  type        = bool
  description = "Optional. Enable Point-To-Site connections. Default: false."
}

variable "vpn_client_configuration" {
  default     = null
  description = "Optional. P2S configuration block. Required when enable_point_to_site is true."

  type = object({
    address_space         = list(string)
    auth_types            = list(string)
    client_protocols      = list(string)
    radius_server_address = optional(string)
    radius_server_secret  = optional(string)

    root_certificate = optional(object({
      name             = string
      public_cert_data = string
    }))

    revoked_certificate = optional(object({
      name       = string
      thumbprint = string
    }))
  })
}

variable "bgp_settings" {
  default     = null
  description = "Optional. BGP configuration block. Required when enable_bgp is true."

  type = object({
    asn         = string
    peer_weight = string

    peering_addresses = object({
      ip_configuration_name = string
      apipa_addresses       = list(string)
    })
  })
}
