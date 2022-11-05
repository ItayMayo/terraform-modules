locals {
  nic_name              = "work_grafana_nic"
  ip_configuration_name = "internal"
}

module "vm_network_interface" {
  source = "github.com/ItayMayo/terraform-modules/tree/master/Network/network-interface"

  name                  = local.nic_name
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
  tags                = var.tags

  size                            = var.vm_size
  admin_username                  = var.vm_admin_username
  admin_password                  = var.vm_admin_password
  disable_password_authentication = var.vm_disable_password_authentication

  network_interface_ids = [modulevm_network_interface.nic_id]

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
}

locals {
  diagnostics_name   = "Virtual Machine Diagnostics"
  target_resource_id = azurerm_linux_virtual_machine.vm.id
}

module "diagnostics_module" {
  source = "github.com/ItayMayo/terraform-azure-logger"

  name                       = local.diagnostics_name
  target_resource_id         = local.resource_id
  log_analytics_workspace_id = var.log_workspace_id
}
