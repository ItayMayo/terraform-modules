variable "nsg_name" {
  type        = string
  description = "Security Group name."
}

variable "nsg_security_rules" {
  type = list(object({
    name : string
    priority : number
    direction : string
    access : string
    protocol : string
    source_port_range : string
    destination_port_range : string
    source_address_prefix : optional(string)
    source_address_prefixes : optional(list(string))
    destination_address_prefix : optional(string)
    destination_address_prefixes : optional(list(string))
  }))

  description = "List of security rules to associate with this security group."
}
