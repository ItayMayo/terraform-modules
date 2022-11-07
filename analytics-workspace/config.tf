variable "location" {
  type        = string
  description = "Location of the resource."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the parent Resource Group."
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "Tags assigned to the resource."
}

variable "name" {
  type        = string
  description = "Workspace name."
}

variable "sku" {
  default     = "PerGB2018"
  type        = string
  description = "Workspace SKU. Default: PerGB2018."
}

variable "retention_in_days" {
  default     = 30
  type        = number
  description = "Log retention in days. Default: 30."
}

variable "daily_quota_gb" {
  default     = -1
  type        = number
  description = "Daily quota in gb. Default: Unlimited."
}

variable "internet_query_enabled" {
  default     = true
  type        = bool
  description = "Workspace query through the internet. Default: true."
}

variable "internet_ingestion_enabled" {
  default     = true
  type        = bool
  description = "Workspace ingestion through the internet. Default: true."
}
