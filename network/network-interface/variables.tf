variable "location" {
  type        = string
  description = "Required. Location of the resource."
}

variable "resource_group_name" {
  type        = string
  description = "Required. Name of the parent Resource Group."
}

variable "log_workspace_id" {
  default     = null
  type        = string
  description = "Optional. ID of the log analytics workspace where logs should be sent to."
}

variable "tags" {
  default     = null
  type        = map(string)
  description = "Required. Tags assigned to the resource."
}

variable "name" {
  type        = string
  description = "Required. Network interface name."
}

variable "ip_configuration_name" {
  type        = string
  description = "Required. Network interface IP configuration name."
}

variable "subnet_id" {
  type        = string
  description = "Required. ID of the subnet to associate the network interface with."
}

variable "private_ip_address_allocation" {
  default     = "Dynamic"
  type        = string
  description = "Optional. Network interface ip allocation method. Default: Dynamic."
}
