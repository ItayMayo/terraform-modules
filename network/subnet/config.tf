variable "resource_group_name" {
  type        = string
  description = "Name of the parent Resource Group."
}

variable "virtual_network_name" {
  type = string
  description = "Name of the Virtual Network to create this subnet in."
}

variable "subnet_name" {
  type        = string
  description = "Name of the subnet."
}

variable "address_prefixes" {
  type        = string
  description = "Address prefixes to be associated with the subnet."
}

variable "nsg_id" {
  default     = null
  type        = string
  description = "ID of the Network Security Group resource to associate this subnet with."
}

variable "route_table_id" {
  default     = null
  type        = string
  description = "ID of the Route Table resource to associate this subnet with."
}