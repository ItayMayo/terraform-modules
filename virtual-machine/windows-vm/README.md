<!-- BEGIN_TF_DOCS -->
# Windows Virtual Machine Module

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_diagnostics"></a> [diagnostics](#module\_diagnostics) | github.com/ItayMayo/terraform-modules//diagnostic-settings | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_disk_sizes_in_gb"></a> [disk\_sizes\_in\_gb](#input\_disk\_sizes\_in\_gb) | (Optional) List of sizes for additional disks to attach to this Virtual Machine. | `list(number)` | <pre>[<br>  -1<br>]</pre> | no |
| <a name="input_identity"></a> [identity](#input\_identity) | (Optional) Identity block assigned to the Virtual Machine. identity\_ids field should only be set when using UserAssigned identities. | <pre>object({<br>    type         = string<br>    identity_ids = optional(list(string))<br>  })</pre> | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Location of the resource. | `string` | n/a | yes |
| <a name="input_log_workspace_id"></a> [log\_workspace\_id](#input\_log\_workspace\_id) | (Required) ID of the log analytics workspace where logs should be sent to. Set as null if not needed. | `string` | n/a | yes |
| <a name="input_os_disk_caching"></a> [os\_disk\_caching](#input\_os\_disk\_caching) | (Optional) OS Disk caching. Default: ReadWrite. | `string` | `"ReadWrite"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Name of the parent Resource Group. | `string` | n/a | yes |
| <a name="input_storage_account_type"></a> [storage\_account\_type](#input\_storage\_account\_type) | (Optional) Type of the Virtual Machine's Storage Account. Default: Standard\_LRS. | `string` | `"Standard_LRS"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Tags assigned to the resource. | `map(string)` | `null` | no |
| <a name="input_vm_admin_password"></a> [vm\_admin\_password](#input\_vm\_admin\_password) | (Optional) Password of the Virtual Machine's admin account. Required when vm\_disable\_password\_authentication is set to false. | `string` | `null` | no |
| <a name="input_vm_admin_username"></a> [vm\_admin\_username](#input\_vm\_admin\_username) | (Required) Username of the Virtual Machine's admin account. | `string` | n/a | yes |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | (Required) Name of the Virtual Machine. | `string` | n/a | yes |
| <a name="input_vm_nic_id"></a> [vm\_nic\_id](#input\_vm\_nic\_id) | (Required) ID of the Network Interface Card to associate with this Virtual Machine. | `string` | n/a | yes |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | (Optional) Size of the Virtual Machine. Default: Standard\_D2s\_v3. | `string` | `"Standard_D2s_v3"` | no |
| <a name="input_vm_source_image_reference"></a> [vm\_source\_image\_reference](#input\_vm\_source\_image\_reference) | (Optional) Virtual Machine OS image reference. Default: WindowsServer 2016-Datacenter. | <pre>object({<br>    publisher = string<br>    offer     = string<br>    sku       = string<br>    version   = string<br>  })</pre> | <pre>{<br>  "offer": "WindowsServer",<br>  "publisher": "MicrosoftWindowsServer",<br>  "sku": "2016-Datacenter",<br>  "version": "latest"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | ID of the Windows Virtual Machine. |
| <a name="output_name"></a> [name](#output\_name) | Name of the Windows Virtual Machine. |
| <a name="output_object"></a> [object](#output\_object) | Object of the Windows Virtual Machine. |

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
<!-- END_TF_DOCS -->