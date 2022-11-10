variable "location" {
  type        = string
  description = "Required. Location of the resource."
}

variable "resource_group_name" {
  type        = string
  description = "Required. Name of the parent Resource Group."
}

variable "log_workspace_id" {
  default     = null
  type        = string
  description = "Optional. ID of the log analytics workspace where logs should be sent to."
}

variable "tags" {
  default     = null
  type        = map(string)
  description = "Optional. Tags assigned to the resource."
}

variable "firewall_name" {
  type        = string
  description = "Required. Name of the Firewall resource."
}

variable "firewall_sku_name" {
  default     = "AZFW_VNet"
  type        = string
  description = "Optional. Name of the Firewall's SKU. Default: AZFW_VNet."
}

variable "firewall_sku_tier" {
  default     = "Standard"
  type        = string
  description = "Optional. Tier of the Firewall's SKU. Default: Standard"
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
  description = "Required. Firewall Subnet ID."
}

variable "management_subnet_id" {
  default     = null
  type        = string
  description = "Optional. Firewall Management Subnet ID. Should only be set if enable_tunneling is true."
}

variable "enable_tunneling" {
  default     = false
  type        = bool
  description = "Optional. Enable Firewall tunneling. Default: false."
}

variable "firewall_policy_name" {
  type        = string
  description = "Required. Name of the Firewall's policy."
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
  description = "Optional. A map of Policy Rule Collection Groups containing Network Rule Collections."
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
  description = "Optional. A map of Policy Rule Collection Groups containing Application Rule Collections."
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
  description = "Optional. A map of Policy Rule Collection Groups containing NAT Rule Collections."
}