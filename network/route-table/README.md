<!-- BEGIN_TF_DOCS -->
# Route Table Module

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_disable_bgp_route_propagation"></a> [disable\_bgp\_route\_propagation](#input\_disable\_bgp\_route\_propagation) | Optional. Disable route table bgp route propagation. Default: false. | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | Required. Location of the resource. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Required. Name of the parent Resource Group. | `string` | n/a | yes |
| <a name="input_route_table_name"></a> [route\_table\_name](#input\_route\_table\_name) | Required. Route table name. | `string` | n/a | yes |
| <a name="input_route_table_routes"></a> [route\_table\_routes](#input\_route\_table\_routes) | Required. Route table routes. | <pre>list(object({<br>    name                   = string<br>    address_prefix         = string<br>    next_hop_type          = string<br>    next_hop_in_ip_address = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Optional. Tags assigned to the resource. | `map(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Route table resource id. |
| <a name="output_name"></a> [name](#output\_name) | Route table resource name. |
| <a name="output_object"></a> [object](#output\_object) | Route table resource object. |

# Usage
```
module "route-table" {
  source = "github.com/ItayMayo/terraform-modules//network/route-table"

  # Generic Resource Configuration
  location            = "westeurope"
  resource_group_name = "my-rg"

  route_table_name              = "route_table_name"
  disable_bgp_route_propagation = true
  route_table_routes            = routes
}
```
<!-- END_TF_DOCS -->