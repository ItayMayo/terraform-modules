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
