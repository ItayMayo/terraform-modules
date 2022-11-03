variable "name" {
  type = string
}

variable "sku" {
  type = string
}

variable "retention_in_days" {
  type = number
}

variable "daily_quota_gb" {
  default = -1
  type    = number
}

variable "internet_query_enabled" {
  default = true
  type    = bool
}

variable "internet_ingestion_enabled" {
  default = true
  type    = bool
}
