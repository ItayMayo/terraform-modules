variable "name" {
  type        = string
  description = "Name of the peering connection."
}

variable "origin_resource_group_name" {
  type        = string
  description = "Name of the origin vnet's resource group."
}

variable "target_resource_group_name" {
  type        = string
  description = "Name of the target vnet's resource group."
}

variable "origin_vnet_name" {
  type        = string
  description = "Name of the origin Virtual Network."
}

variable "target_vnet_name" {
  type        = string
  description = "Name of the target Virtual Network."
}

variable "origin_vnet_id" {
  type        = string
  description = "ID of the target vnet."
}

variable "target_vnet_id" {
  type        = string
  description = "ID of the target vnet."
}

variable "allow_forwarded_traffic" {
  default     = true
  type        = bool
  description = "Allow forwarded traffic from peered network. Default: true."
}

variable "allow_gateway_transit" {
  default     = true
  type        = bool
  description = "Allow gateway transit of peered network's traffic. Default: true."
}

variable "use_remote_gateways" {
  default     = true
  type        = bool
  description = "Use peered network's remote gateway. Default: true."
}
