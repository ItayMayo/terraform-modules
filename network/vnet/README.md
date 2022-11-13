# Virtual Network

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
| <a name="module_subnets"></a> [subnets](#module\_subnets) | github.com/ItayMayo/terraform-modules//network/subnet | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | Required. VNet Address Space. Usually has /16 CIDR. | `list(string)` | n/a | yes |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | Optional. DNS servers to be associated with this Virtual Network.. | `list(string)` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | Required. Location of the resource. | `string` | n/a | yes |
| <a name="input_log_workspace_id"></a> [log\_workspace\_id](#input\_log\_workspace\_id) | Optional. ID of the log analytics workspace where logs should be sent to. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Required. Name of the parent Resource Group. | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Required. Map of subnets to be associated with this Virtual Network. | <pre>map(object({<br>    subnet_name      = string<br>    address_prefixes = list(string)<br>    nsg_id           = optional(string)<br>    route_table_id   = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Optional. Tags assigned to the resource. | `map(string)` | `null` | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Required. Name of the vnet. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | ID of the Virtual Network resource. |
| <a name="output_name"></a> [name](#output\_name) | Name of the Virtual Network resource. |
| <a name="output_object"></a> [object](#output\_object) | Object of the Virtual Network resource. |
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | List of subnet resource ids associated with the Virtual Network resource. |
| <a name="output_subnet_objects"></a> [subnet\_objects](#output\_subnet\_objects) | Objects of the Subnet resources associated with the Virtual Network resource. |
<!-- END_TF_DOCS -->