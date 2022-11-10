variable "resource_group_name" {
  type        = string
  description = "Required. Name of the parent Resource Group."
}

variable "tags" {
  default     = null
  type        = map(string)
  description = "Required. Tags assigned to the resource."
}

variable "zone_name" {
  type        = string
  description = "Required. Name of the DNS zone."
}

variable "zone_a_records" {
  type = map(object({
    name    = string
    ttl     = number
    records = list(string)
  }))

  default     = null
  description = "Optional. DNS Zone A records."
}

variable "vnet_ids" {
  type        = map(string)
  description = "Required. DNS Zone associated vnet ids."
}
