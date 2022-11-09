variable "resource_group_name" {
  type        = string
  description = "Name of the parent Resource Group."
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "Tags assigned to the resource."
}

variable "zone_name" {
  type        = string
  description = "Name of the DNS zone."
}

variable "zone_a_records" {
  type = map(object({
    name    = string
    ttl     = number
    records = list(string)
  }))

  description = "DNS Zone A records."
}

variable "vnet_ids" {
  type        = map(string)
  description = "DNS Zone associated vnet ids."
}
