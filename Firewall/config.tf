variable "firewall_name" {
  type = string
}

variable "firewall_sku_name" {
  type = string
}

variable "firewall_sku_tier" {
  type = string
}

variable "firewall_dns_servers" {
  default = null
  type    = list(string)
}

variable "firewall_zones" {
  default = null
  type    = list(string)
}

variable "firewall_ip_configuration" {
  type = list(object({
    name                 = string
    subnet_id            = string
    public_ip_address_id = string
  }))

  description = "Enter 2 configurations when using tunneling."
}

variable "enable_tunneling" {
  default = false
  type    = bool
}

variable "firewall_policy_name" {
  type = string
}
