<!-- BEGIN_TF_DOCS -->
# Virtual Machine Module

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_diagnostics"></a> [diagnostics](#module\_diagnostics) | github.com/ItayMayo/terraform-modules//diagnostic-settings | n/a |
| <a name="module_vm-network-interface"></a> [vm-network-interface](#module\_vm-network-interface) | github.com/ItayMayo/terraform-modules//Network/network-interface | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_managed_disk.managed_disk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk) | resource |
| [azurerm_virtual_machine_data_disk_attachment.vm_disk_attachment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment) | resource |
| [azurerm_windows_virtual_machine.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_disk_sizes_in_gb"></a> [disk\_sizes\_in\_gb](#input\_disk\_sizes\_in\_gb) | (Optional) List of sizes for additional disks to attach to this Virtual Machine. Sizes must be between 1gb and 2tb. | `list(number)` | <pre>[<br>  -1<br>]</pre> | no |
| <a name="input_identity"></a> [identity](#input\_identity) | (Optional) Identity block assigned to the Virtual Machine. identity\_ids field should only be set when using UserAssigned identities. | <pre>object({<br>    type         = string<br>    identity_ids = optional(list(string))<br>  })</pre> | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Location of the resource. | `string` | n/a | yes |
| <a name="input_log_workspace_id"></a> [log\_workspace\_id](#input\_log\_workspace\_id) | (Required) ID of the log analytics workspace where logs should be sent to. Set as null if not needed. | `string` | n/a | yes |
| <a name="input_nic_nsg_id"></a> [nic\_nsg\_id](#input\_nic\_nsg\_id) | (Optional) ID of a Network Security Group to associate with the Virutal Machine. | `string` | `null` | no |
| <a name="input_nic_subnet_id"></a> [nic\_subnet\_id](#input\_nic\_subnet\_id) | (Required) Subnet ID in which the Virtual Machine's NIC should be created. | `string` | n/a | yes |
| <a name="input_os_disk_caching"></a> [os\_disk\_caching](#input\_os\_disk\_caching) | (Optional) OS Disk caching. Default: ReadWrite. | `string` | `"ReadWrite"` | no |
| <a name="input_os_disk_size_gb"></a> [os\_disk\_size\_gb](#input\_os\_disk\_size\_gb) | (Optional) Size of the Virtual Machine's Operating System disk in Gigabytes. Sizes must be between 25gb and 2tb. | `number` | `-1` | no |
| <a name="input_private_ip_address"></a> [private\_ip\_address](#input\_private\_ip\_address) | (Optional) Private IP Address to associate with this Virtual Machine. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Name of the parent Resource Group. | `string` | n/a | yes |
| <a name="input_storage_account_type"></a> [storage\_account\_type](#input\_storage\_account\_type) | (Optional) Type of the Virtual Machine's Storage Account. Default: Standard\_LRS. | `string` | `"Standard_LRS"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Tags assigned to the resource. | `map(string)` | `null` | no |
| <a name="input_vm_admin_password"></a> [vm\_admin\_password](#input\_vm\_admin\_password) | (Optional) Password of the Virtual Machine's admin account. Required when vm\_disable\_password\_authentication is set to false. | `string` | `null` | no |
| <a name="input_vm_admin_ssh_key"></a> [vm\_admin\_ssh\_key](#input\_vm\_admin\_ssh\_key) | (Optional) SSH publickey to use when logging in. Only applies to Linux VMs. Required when vm\_disable\_password\_authentication is set to true. | <pre>object({<br>    username   = string<br>    public_key = string<br>  })</pre> | `null` | no |
| <a name="input_vm_admin_username"></a> [vm\_admin\_username](#input\_vm\_admin\_username) | (Required) Username of the Virtual Machine's admin account. | `string` | n/a | yes |
| <a name="input_vm_disable_password_authentication"></a> [vm\_disable\_password\_authentication](#input\_vm\_disable\_password\_authentication) | (Optional) Disable VM password authentication and use SSH publickey. Only applies to Linux VMs. Default: true. | `bool` | `true` | no |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | (Required) Name of the Virtual Machine. | `string` | n/a | yes |
| <a name="input_vm_os_name"></a> [vm\_os\_name](#input\_vm\_os\_name) | (Optional) Name of the Operating System. Accepted Values: Linux, Windows. Default: Linux. | `string` | `"Linux"` | no |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | (Optional) Size of the Virtual Machine. Default: Standard\_D2s\_v3. | `string` | `"Standard_D2s_v3"` | no |
| <a name="input_vm_source_image_reference"></a> [vm\_source\_image\_reference](#input\_vm\_source\_image\_reference) | (Optional) Virtual Machine OS image reference. Default: UbuntuServer 16.04-LTS. | <pre>object({<br>    publisher = string<br>    offer     = string<br>    sku       = string<br>    version   = string<br>  })</pre> | <pre>{<br>  "offer": "UbuntuServer",<br>  "publisher": "Canonical",<br>  "sku": "16.04-LTS",<br>  "version": "latest"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Virtual Machine resource id. |
| <a name="output_name"></a> [name](#output\_name) | Virtual Machine resource name. |
| <a name="output_nic_object"></a> [nic\_object](#output\_nic\_object) | Network Interface resource object associated with the Virtual Machine. |
| <a name="output_object"></a> [object](#output\_object) | Virtual Machine resource object. |
| <a name="output_vm_os_name"></a> [vm\_os\_name](#output\_vm\_os\_name) | Name of the Operating System for the Virtual Machine. |
<!-- END_TF_DOCS -->