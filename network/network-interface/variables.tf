variable "location" {
  type        = string
  description = "(Required) Location of the resource."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Name of the parent Resource Group."
}

variable "log_workspace_id" {
  type        = string
  description = "(Required) ID of the log analytics workspace where logs should be sent to. Set as null if not needed."
}

variable "tags" {
  default     = null
  type        = map(string)
  description = "(Required) Tags assigned to the resource."
}

variable "name" {
  type        = string
  description = "(Required) Network interface name."
}

variable "ip_configuration_name" {
  default     = "internal"
  type        = string
  description = "(Optional) Network interface IP configuration name. Defualt: internal."
}

variable "subnet_id" {
  type        = string
  description = "(Required) ID of the subnet to associate the network interface with."
}

variable "private_ip_address" {
  default     = null
  type        = string
  description = "(Optional) Network interface Private IP address."
}
