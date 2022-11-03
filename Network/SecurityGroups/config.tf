variable "security_groups" {
  default = {
    nsg = {
      nsg_name           = null
      nsg_security_rules = null
    }
  }

  type = map(any)
}

variable "group_association" {
  default = {
    nsg-association = {
      subnet_id = null
      nsg_name  = null
    }
  }

  type = map(any)
}
