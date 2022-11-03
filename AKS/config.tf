variable "cluster_name" {
  type = string
}

variable "dns_prefix" {
  type = string
}

variable "private_cluster_enabled" {
  type = bool
}

variable "private_dns_zone_id" {
  default = null
  type    = string
}

variable "public_network_access_enabled" {
  default = true
  type    = bool
}

variable "default_node_pool" {
  type = object({
    name                  = string
    node_count            = number
    vm_size               = string
    enable_node_public_ip = bool
    os_sku                = string
    enable_auto_scaling   = bool
    max_count             = number
    min_count             = number
    vnet_subnet_id        = string
  })
}

variable "identity" {
  type = object({
    type         = string
    identity_ids = list(string)
  })
}

variable "network_profile" {
  type = object({
    network_plugin = string
    network_mode   = string
    network_policy = string
  })
}
