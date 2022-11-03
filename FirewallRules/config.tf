variable "collection_group_name" {
  type = string
}

variable "policy_id" {
  type = string
}

variable "priority" {
  type = number
}

variable "rule_collections" {
  type = object({
    application_rule_collections = list(any)
    network_rule_collections     = list(any)
    nat_rule_collections         = list(any)
  })
}
