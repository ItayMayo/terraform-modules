variable "location" {
  type        = string
  description = "(Required) Location of the resource."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Name of the parent Resource Group."
}

variable "tags" {
  default     = null
  type        = map(string)
  description = "(Required) Tags assigned to the resource."
}

variable "name" {
  type        = string
  description = "(Required) Private Endpoint name."
}

variable "private_endpoint_subnet_id" {
  type        = string
  description = "(Required) ID of the subnet in which to create a Private Endpoint."
}

variable "endpoint_ip_address" {
  default     = null
  type        = string
  description = "(Optional) Private IP Address to associate with this Private Endpoint."
}

variable "target_resource_id" {
  type        = string
  description = "(Required) ID of the Resource to associate with this private endpoint."
}

variable "subresource_names" {
  type        = list(string)
  description = "(Required) Name of the subresources to associate this endpoint with."
}

variable "is_manual_connection" {
  default     = false
  type        = bool
  description = "(Optional) Is the connection a manual connection. Default: false."
}
