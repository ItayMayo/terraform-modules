# Usage

```
module "linux-vm" {
  source = "./linux-vm"

  resource_group_name = "test-rg"
  location            = "westeurope"
  log_workspace_id    = var.log_workspace_id

  vm_name = "linux-vm"
  vm_size = var.vm_size

  vm_admin_username                  = var.vm_admin_username
  vm_admin_password                  = var.vm_admin_password
  vm_disable_password_authentication = var.vm_disable_password_authentication
  vm_admin_ssh_key                   = var.vm_admin_ssh_key

  vm_nic_id = module.vm-network-interface.id

  vm_source_image_reference = var.vm_source_image_reference
  identity                  = var.identity

  storage_account_type = var.storage_account_type
  os_disk_caching      = var.os_disk_caching
  disk_sizes_in_gb     = var.disk_sizes_in_gb

  tags = var.tags

  depends_on = [
    module.vm-network-interface
  ]
}

```