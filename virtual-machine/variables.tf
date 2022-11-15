variable "location" {
  type        = string
  description = "(Required) Location of the resource."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Name of the parent Resource Group."
}

variable "log_workspace_id" {
  type        = string
  description = "(Required) ID of the log analytics workspace where logs should be sent to. Set as null if not needed."
}

variable "tags" {
  default     = null
  type        = map(string)
  description = "(Optional) Tags assigned to the resource."
}

variable "vm_name" {
  type        = string
  description = "(Required) Name of the Virtual Machine."
}

variable "vm_os_name" {
  default     = "Linux"
  type        = string
  description = "(Optional) Name of the Operating System. Accepted Values: Linux, Windows. Default: Linux."

  validation {
    condition     = contains(["Windows", "Linux"], var.vm_os_name)
    error_message = "Allowed values for input_parameter are \"Windows\", or \"Linux\"."
  }
}

variable "vm_size" {
  default     = "Standard_D2s_v3"
  type        = string
  description = "(Optional) Size of the Virtual Machine. Default: Standard_D2s_v3."
}

variable "vm_admin_username" {
  type        = string
  description = "(Required) Username of the Virtual Machine's admin account."
}

variable "vm_admin_password" {
  default     = null
  type        = string
  sensitive   = true
  description = "(Optional) Password of the Virtual Machine's admin account. Required when vm_disable_password_authentication is set to false."
}

variable "vm_disable_password_authentication" {
  default     = true
  type        = bool
  description = "(Optional) Disable VM password authentication and use SSH publickey. Only applies to Linux VMs. Default: true."
}

variable "vm_admin_ssh_key" {
  default = null

  type = object({
    username   = string
    public_key = string
  })

  sensitive   = true
  description = "(Optional) SSH publickey to use when logging in. Only applies to Linux VMs. Required when vm_disable_password_authentication is set to true."
}

variable "vm_source_image_reference" {
  default = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })

  description = "(Optional) Virtual Machine OS image reference. Default: UbuntuServer 16.04-LTS."
}

variable "nic_subnet_id" {
  type        = string
  description = "(Required) Subnet ID in which the Virtual Machine's NIC should be created."
}

variable "os_disk_caching" {
  default     = "ReadWrite"
  type        = string
  description = "(Optional) OS Disk caching. Default: ReadWrite."
}

variable "storage_account_type" {
  default     = "Standard_LRS"
  type        = string
  description = "(Optional) Type of the Virtual Machine's Storage Account. Default: Standard_LRS."
}

variable "identity" {
  default = null

  type = object({
    type         = string
    identity_ids = optional(list(string))
  })

  description = "(Optional) Identity block assigned to the Virtual Machine. identity_ids field should only be set when using UserAssigned identities."
}

variable "disk_sizes_in_gb" {
  default = [-1]

  type        = list(number)
  description = "(Optional) List of sizes for additional disks to attach to this Virtual Machine."
}

variable "private_ip_address" {
  default     = null
  type        = string
  description = "(Optional) Private IP Address to associate with this Virtual Machine."
}
