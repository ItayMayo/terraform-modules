variable "name" {
  type        = string
  description = "(Required) Name of the peering connection."
}

variable "origin_resource_group_name" {
  type        = string
  description = "(Required) Name of the origin vnet's resource group."
}

variable "target_resource_group_name" {
  type        = string
  description = "(Required) Name of the target vnet's resource group."
}

variable "origin_vnet_name" {
  type        = string
  description = "(Required) Name of the origin Virtual Network."
}

variable "target_vnet_name" {
  type        = string
  description = "(Required) Name of the target Virtual Network."
}

variable "origin_vnet_id" {
  type        = string
  description = "(Required) ID of the target vnet."
}

variable "target_vnet_id" {
  type        = string
  description = "(Required) ID of the target vnet."
}

variable "allow_forwarded_traffic" {
  default     = true
  type        = bool
  description = "(Optional) Allow forwarded traffic from peered network. Default: true."
}

variable "allow_origin_gateway_transit" {
  default     = true
  type        = bool
  description = "(Optional) Allow gateway transit of peered network's traffic. If true, allow_target_gateway_transit must be set to false and vice versa. Default: true."
}

variable "allow_target_gateway_transit" {
  default     = false
  type        = bool
  description = "(Optional) Allow gateway transit of origin network's traffic. If true, allow_origin_gateway_transit must be set to false and vice versa. Default: false."
}
