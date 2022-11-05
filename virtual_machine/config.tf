variable "vm_name" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "vm_admin_username" {
  type = string
}

variable "vm_admin_password" {
  default   = null
  type      = string
  sensitive = true
}

variable "vm_disable_password_authentication" {
  default = true
  type    = bool
}

variable "vm_admin_ssh_key" {
  type = object({
    username   = string
    public_key = string
  })

  sensitive = true
}

variable "vm_source_image_reference" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}

variable "vm_nic_ids" {
  type = list(string)
}

variable "os_disk_caching" {
  type = string
}

variable "storage_account_type" {
  type = string
}

variable "identity" {
  type = object({
    type         = string
    identity_ids = list(string)
  })

  default = null
}
