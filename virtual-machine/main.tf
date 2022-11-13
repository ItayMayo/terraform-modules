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

  ip_configuration_name = local.ip_configuration_name
  subnet_id             = var.nic_subnet_id
  tags                  = var.tags
}

locals {
  identity_provided = var.identity != null
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location

  size                            = var.vm_size
  admin_username                  = var.vm_admin_username
  admin_password                  = var.vm_admin_password
  disable_password_authentication = var.vm_disable_password_authentication

  network_interface_ids = [module.vm-network-interface.id]

  os_disk {
    caching              = var.os_disk_caching
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.vm_source_image_reference["publisher"]
    offer     = var.vm_source_image_reference["offer"]
    sku       = var.vm_source_image_reference["sku"]
    version   = var.vm_source_image_reference["version"]
  }

  dynamic "admin_ssh_key" {
    for_each = var.vm_disable_password_authentication ? [var.vm_admin_ssh_key] : []

    content {
      username   = admin_ssh_key.value["username"]
      public_key = admin_ssh_key.value["public_key"]
    }
  }

  dynamic "identity" {
    for_each = local.identity_provided ? [var.identity] : []

    content {
      type         = identity.value["type"]
      identity_ids = identity.value["identity_ids"]
    }
  }

  tags = var.tags

  depends_on = [
    module.vm-network-interface
  ]
}

locals {
  create_additional_disks           = !contains(var.disk_sizes_in_gb, -1)
  managed_disk_name_prefix          = "${var.vm_name}-managed-disk"
  managed_disk_storage_account_type = "Standard_LRS"
  managed_disk_create_option        = "Empty"
}

resource "azurerm_managed_disk" "managed_disk" {
  for_each = local.create_additional_disks ? { for index, value in range(length(var.disk_sizes_in_gb)) : index => value } : {}

  name                 = "${local.managed_disk_name_prefix}-${each.key}"
  resource_group_name  = var.resource_group_name
  location             = var.location
  storage_account_type = local.managed_disk_storage_account_type
  create_option        = local.managed_disk_create_option
  disk_size_gb         = each.value
}

locals {
  vm_disk_caching = "ReadWrite"
}

resource "azurerm_virtual_machine_data_disk_attachment" "vm_disk_attachment" {
  for_each = local.create_additional_disks ? { for index in range(length(var.disk_sizes_in_gb)) : index => index } : {}

  managed_disk_id    = azurerm_managed_disk.managed_disk[each.value].id
  virtual_machine_id = azurerm_linux_virtual_machine.vm.id
  lun                = (each.value + 1) * 10
  caching            = local.vm_disk_caching

  depends_on = [
    azurerm_linux_virtual_machine.vm
  ]
}

locals {
  diagnostics_name               = "${var.vm_name}-virtual-machine-diagnostics"
  target_resource_id             = azurerm_linux_virtual_machine.vm.id
  diagnostics_workspace_provided = var.log_workspace_id != null
}

module "diagnostics" {
  source   = "github.com/ItayMayo/terraform-modules//diagnostic-settings"
  for_each = local.diagnostics_workspace_provided ? [1] : []

  name                       = local.diagnostics_name
  target_resource_id         = local.target_resource_id
  log_analytics_workspace_id = var.log_workspace_id

  depends_on = [
    azurerm_linux_virtual_machine.vm
  ]
}
