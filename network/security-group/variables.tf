variable "location" {
  type        = string
  description = "Required. Location of the resource."
}

variable "resource_group_name" {
  type        = string
  description = "Required. Name of the parent Resource Group."
}

variable "tags" {
  default     = null
  type        = map(string)
  description = "Optional. Tags assigned to the resource."
}

variable "nsg_name" {
  type        = string
  description = "Required. Security Group name."
}

variable "nsg_security_rules" {
  type = list(object({
    name = string
    priority = number
    direction = string
    access = string
    protocol = string
    source_port_range = string
    destination_port_range = string
    source_address_prefix = optional(string)
    source_address_prefixes = optional(list(string))
    destination_address_prefix = optional(string)
    destination_address_prefixes = optional(list(string))
  }))

  description = "Required. List of security rules to associate with this security group."
}
