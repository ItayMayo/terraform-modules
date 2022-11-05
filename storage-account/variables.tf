locals {
  network_rules_provided = var.network_rules != null
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