# Subnet

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.nsg_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_route_table_association.route_table_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_prefixes"></a> [address\_prefixes](#input\_address\_prefixes) | Required. Address prefixes to be associated with the subnet. | `list(string)` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Required. Name of the subnet. | `string` | n/a | yes |
| <a name="input_nsg_id"></a> [nsg\_id](#input\_nsg\_id) | Optional. ID of the Network Security Group resource to associate this subnet with. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Required. Name of the parent Resource Group. | `string` | n/a | yes |
| <a name="input_route_table_id"></a> [route\_table\_id](#input\_route\_table\_id) | Optional. ID of the Route Table resource to associate this subnet with. | `string` | `null` | no |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | Required. Name of the Virtual Network to create this subnet in. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | ID of the subnet resource. |
| <a name="output_name"></a> [name](#output\_name) | Name of the subnet resource. |
| <a name="output_object"></a> [object](#output\_object) | Object of the subnet resource. |
<!-- END_TF_DOCS -->