locals {
  aad_audience = "41b23e61-6c1e-4545-b367-cd054e0ed4b4"
}

variable "resource_location" {
  type        = string
  description = "Location of the resource."
}

variable "resource_group_name" {
  type = string
}

variable "log_workspace_id" {
  default = null
  type    = string
}
