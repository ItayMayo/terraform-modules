variable "name" {
  type        = string
  description = "Required. Settings link name."
}

variable "subscription_id" {
  default     = null
  type        = string
  description = "Optional. Subscription ID. Provide only when enabling Activity Logs."
}

variable "target_resource_id" {
  default     = null
  type        = string
  description = "Optional. ID of the resource to monitor. Provide only when Subscription ID is not specified."
}

variable "storage_account_id" {
  default     = null
  type        = string
  description = "Optional. ID of the Storage Account to store the logs in."
}

variable "log_analytics_workspace_id" {
  default     = null
  type        = string
  description = "Optional. ID of the Log Analytics Workspace to store the logs in."
}

variable "eventhub_name" {
  default     = null
  type        = string
  description = "Optional. Name of an Eventhub."
}

variable "eventhub_authorization_rule_id" {
  default     = null
  type        = string
  description = "Optional. ID of an Eventhub authorization rule."
}

variable "retention_policy_days" {
  default     = null
  type        = number
  description = "Optional. Number of days to retain logs. Default: Unlimited."
}
