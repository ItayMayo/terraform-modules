variable "location" {
  type        = string
  description = "Location of the resource."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the parent Resource Group."
}

variable "log_workspace_id" {
  default     = null
  type        = string
  description = "ID of the log analytics workspace where logs should be sent to."
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "Tags assigned to the resource."
}

variable "name" {
  type        = string
  description = "Network interface name."
}

variable "ip_configuration_name" {
  type        = string
  description = "Network interface IP configuration name."
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet to associate the network interface with."
}

variable "private_ip_address_allocation" {
  default     = "Dynamic"
  type        = string
  description = "Network interface ip allocation method. Default: Dynamic."
}
