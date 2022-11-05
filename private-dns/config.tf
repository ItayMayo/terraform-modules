variable "zone_name" {
  type = string
}

variable "zone_a_records" {
  type = map(object({
    name    = string
    ttl     = number
    records = list(string)
  }))
}

variable "vnet_ids" {
  type = map(string)
}
