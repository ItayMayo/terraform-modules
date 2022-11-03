variable "name" {
  type = string
}

variable "account_tier" {
  type = string
}

variable "account_kind" {
  type = string
}

variable "replication_type" {
  type = string
}

variable "allow_nested_items_to_be_public" {
  type = bool
}

variable "public_network_access_enabled" {
  type = bool
}

variable "network_rules" {
  type = list(object({
    default_action             = string
    bypass                     = list(string)
    ip_rules                   = list(string)
    virtual_network_subnet_ids = list(string)

    private_link_access = object({
      endpoint_resource_id = string
      endpoint_tenant_id   = string
    })
  }))
}
