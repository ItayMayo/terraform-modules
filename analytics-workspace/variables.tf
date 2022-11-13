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
  description = "(Optional) Tags assigned to the resource."
}

variable "name" {
  type        = string
  description = "(Required) Workspace name."
}

variable "sku" {
  default     = "PerGB2018"
  type        = string
  description = "(Optional) Workspace SKU. Default: PerGB2018."
}

variable "retention_in_days" {
  default     = 30
  type        = number
  description = "(Optional) Log retention in days. Default: 30."
}

variable "daily_quota_gb" {
  default     = -1
  type        = number
  description = "(Optional) Daily quota in gb. Default: Unlimited."
}