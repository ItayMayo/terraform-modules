# Network Interface

<!-- BEGIN_TF_DOCS -->
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

## Resources

| Name | Type |
|------|------|
| [azurerm_network_interface.network_interface](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ip_configuration_name"></a> [ip\_configuration\_name](#input\_ip\_configuration\_name) | Required. Network interface IP configuration name. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Required. Location of the resource. | `string` | n/a | yes |
| <a name="input_log_workspace_id"></a> [log\_workspace\_id](#input\_log\_workspace\_id) | Optional. ID of the log analytics workspace where logs should be sent to. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Required. Network interface name. | `string` | n/a | yes |
| <a name="input_private_ip_address_allocation"></a> [private\_ip\_address\_allocation](#input\_private\_ip\_address\_allocation) | Optional. Network interface ip allocation method. Default: Dynamic. | `string` | `"Dynamic"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Required. Name of the parent Resource Group. | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Required. ID of the subnet to associate the network interface with. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Required. Tags assigned to the resource. | `map(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | ID of the network interface resource. |
| <a name="output_name"></a> [name](#output\_name) | Name of the network interface resource. |
| <a name="output_object"></a> [object](#output\_object) | Object of the network interface resource. |
<!-- END_TF_DOCS -->