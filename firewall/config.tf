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

variable "firewall_name" {
  type        = string
  description = "Name of the Firewall resource."
}

variable "firewall_sku_name" {
  default     = "AZFW_VNet"
  type        = string
  description = "Name of the Firewall's SKU. Default: AZFW_VNet."
}

variable "firewall_sku_tier" {
  default     = "Standard"
  type        = string
  description = "Tier of the Firewall's SKU. Default: Standard"
}

variable "firewall_dns_servers" {
  default     = null
  type        = list(string)
  description = "Optional. Firewall associated DNS servers."
}

variable "firewall_zones" {
  default     = null
  type        = list(string)
  description = "Optional. Availability Zones where the Firewall should be deployed to."
}

variable "subnet_id" {
  type        = string
  description = "Firewall Subnet ID."
}

variable "management_subnet_id" {
  default     = null
  type        = string
  description = "Firewall Management Subnet ID. Should only be set if enable_tunneling is true."
}

variable "enable_tunneling" {
  default     = false
  type        = bool
  description = "Enable Firewall tunneling. Default: false."
}

variable "firewall_policy_name" {
  type        = string
  description = "Name of the Firewall's policy."
}

variable "policy_collection_group_name" {
  type        = string
  description = "Name of the Policy Rule Collection Group."
}

variable "collection_priority" {
  type        = number
  description = "Priority of the collection group."
}

variable "rule_collections" {
  type = object({
    application_rule_collections = optional(list(object({
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
    })))

    network_rule_collections = optional(list(object({
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
    })))

    nat_rule_collections = optional(list(any))
  })

  description = "Collection rules."
}
