variable "name" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "remote_vnet_id" {
  type = string
}

variable "allow_forwarded_traffic" {
  type = bool
}

variable "allow_gateway_transit" {
  type = bool
}

variable "use_remote_gateways" {
  type = bool
}
