/**
* # Virtual Machine Module
*/

locals {
  nic_name              = "${var.vm_name}-nic"
  ip_configuration_name = "internal"
}

module "vm-network-interface" {
  source = "github.com/ItayMayo/terraform-modules//Network/network-interface"

  name                = local.nic_name
  resource_group_name = var.resource_group_name
  location            = var.location
  log_workspace_id    = var.log_workspace_id

  private_ip_address    = var.private_ip_address
  ip_configuration_name = local.ip_configuration_name
  subnet_id             = var.nic_subnet_id

  tags = var.tags
}

module "windows-vm" {
  source = "./windows-vm"

  for_each = var.vm_os_name == "Windows" ? { vm = "Windows" } : {}

  resource_group_name = var.resource_group_name
  location            = var.location
  log_workspace_id    = var.log_workspace_id

  vm_name = var.vm_name
  vm_size = var.vm_size

  vm_admin_username = var.vm_admin_username
  vm_admin_password = var.vm_admin_password

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

module "linux-vm" {
  source = "./linux-vm"

  for_each = var.vm_os_name == "Linux" ? { vm = "Linux" } : {}

  resource_group_name = var.resource_group_name
  location            = var.location
  log_workspace_id    = var.log_workspace_id

  vm_name = var.vm_name
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