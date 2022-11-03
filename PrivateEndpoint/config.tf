variable "endpoint_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "service_connection_name" {
  type = string
}

variable "service_connection_resource_id" {
  type = string
}

variable "service_connection_is_manual_connection" {
  type = bool
}

variable "subresource_name" {
  type = list(string)
}
