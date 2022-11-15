variable "location" {
  type        = string
  description = "(Required) Location of the resource."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Name of the parent Resource Group."
}

variable "firewall_policy_name" {
  type        = string
  description = "(Required) Name of the Firewall's policy."
}

variable "network_collection_groups" {
  type = map(object({
    name     = string
    priority = number

    network_rule_collections = list(object({
      name     = string
      priority = number
      action   = string

      rule = list(object({
        name                  = string
        protocols             = list(string)
        source_addresses      = list(string)
        destination_addresses = list(string)
        destination_ports     = list(string)
      }))
    }))
  }))

  default     = null
  description = "(Optional) A map of Policy Rule Collection Groups containing Network Rule Collections."
}

variable "application_collection_groups" {
  type = map(object({
    name     = string
    priority = number

    application_rule_collections = list(object({
      name     = string
      priority = number
      action   = string

      rule = list(object({
        name = string

        protocols = list(object({
          type = string
          port = number
        }))

        source_addresses  = list(string)
        destination_fqdns = list(string)
      }))
    }))
  }))

  default     = null
  description = "(Optional) A map of Policy Rule Collection Groups containing Application Rule Collections."
}

variable "nat_collection_groups" {
  type = map(object({
    name     = string
    priority = number

    nat_rule_collections = list(object({
      name     = string
      priority = number
      action   = string

      rule = list(object({
        name                = string
        protocols           = list(string)
        source_addresses    = list(string)
        destination_address = string
        destination_ports   = list(string)
        translated_address  = string
        translated_port     = string
      }))
    }))
  }))

  default     = null
  description = "(Optional) A map of Policy Rule Collection Groups containing NAT Rule Collections."
}
