variable "resource_group_name" {
  type        = string
  description = "Name of the parent Resource Group."
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "Tags assigned to the resource."
}
