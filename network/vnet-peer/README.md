<!-- BEGIN_TF_DOCS -->
# Virtual Network Peering

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_forwarded_traffic"></a> [allow\_forwarded\_traffic](#input\_allow\_forwarded\_traffic) | Optional. Allow forwarded traffic from peered network. Default: true. | `bool` | `true` | no |
| <a name="input_allow_origin_gateway_transit"></a> [allow\_origin\_gateway\_transit](#input\_allow\_origin\_gateway\_transit) | Optional. Allow gateway transit of peered network's traffic. If true, allow\_target\_gateway\_transit must be set to false and vice versa. Default: true. | `bool` | `true` | no |
| <a name="input_allow_target_gateway_transit"></a> [allow\_target\_gateway\_transit](#input\_allow\_target\_gateway\_transit) | Optional. Allow gateway transit of origin network's traffic. If true, allow\_origin\_gateway\_transit must be set to false and vice versa. Default: false. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Required. Name of the peering connection. | `string` | n/a | yes |
| <a name="input_origin_resource_group_name"></a> [origin\_resource\_group\_name](#input\_origin\_resource\_group\_name) | Required. Name of the origin vnet's resource group. | `string` | n/a | yes |
| <a name="input_origin_vnet_id"></a> [origin\_vnet\_id](#input\_origin\_vnet\_id) | Required. ID of the target vnet. | `string` | n/a | yes |
| <a name="input_origin_vnet_name"></a> [origin\_vnet\_name](#input\_origin\_vnet\_name) | Required. Name of the origin Virtual Network. | `string` | n/a | yes |
| <a name="input_target_resource_group_name"></a> [target\_resource\_group\_name](#input\_target\_resource\_group\_name) | Required. Name of the target vnet's resource group. | `string` | n/a | yes |
| <a name="input_target_vnet_id"></a> [target\_vnet\_id](#input\_target\_vnet\_id) | Required. ID of the target vnet. | `string` | n/a | yes |
| <a name="input_target_vnet_name"></a> [target\_vnet\_name](#input\_target\_vnet\_name) | Required. Name of the target Virtual Network. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_origin_peering_id"></a> [origin\_peering\_id](#output\_origin\_peering\_id) | ID of the origin's peering resource. |
| <a name="output_origin_peering_name"></a> [origin\_peering\_name](#output\_origin\_peering\_name) | Name of the origin's peering resource. |
| <a name="output_origin_peering_object"></a> [origin\_peering\_object](#output\_origin\_peering\_object) | Object of the origin's peering resource. |
| <a name="output_target_peering_id"></a> [target\_peering\_id](#output\_target\_peering\_id) | ID of the target's peering resource. |
| <a name="output_target_peering_name"></a> [target\_peering\_name](#output\_target\_peering\_name) | Name of the target's peering resource. |
| <a name="output_target_peering_object"></a> [target\_peering\_object](#output\_target\_peering\_object) | Object of the target's peering resource. |

# Usage

```
module "vnet-peering" {
  source = "github.com/ItayMayo/terraform-modules//network/vnet-peer"

  name = "my-peering"

  origin_resource_group_name = "my-rg1"
  target_resource_group_name = "my-rg2"

  origin_vnet_name = "origin_vnet_name"
  target_vnet_name = "target_vnet_name"
  origin_vnet_id   = "origin_vnet_id"
  target_vnet_id   = "target_vnet_id"
}
```
<!-- END_TF_DOCS -->