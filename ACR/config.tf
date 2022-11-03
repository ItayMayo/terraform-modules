variable "acr_name" {
  type        = string
  description = "Name of the Container Registry."
}

variable "acr_sku" {
  type        = string
  description = "Container Registry SKU name."
}

variable "admin_enabled" {
  default     = false
  type        = bool
  description = "Enable admin account."
}

variable "public_network_access_enabled" {
  default     = true
  type        = bool
  description = "Enable ACR public network access."
}

variable "data_endpoint_enabled" {
  default     = false
  type        = bool
  description = "Enable ACR Data Endpoint."
}
