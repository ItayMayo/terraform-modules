<!-- BEGIN_TF_DOCS -->
# Route Table Route Module

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Required. Name of the parent Resource Group. | `string` | n/a | yes |
| <a name="input_route_table_name"></a> [route\_table\_name](#input\_route\_table\_name) | Required. Name of the Route Table to assign the Routes to. | `string` | n/a | yes |
| <a name="input_route_table_routes"></a> [route\_table\_routes](#input\_route\_table\_routes) | Required. Routes to assign to the route table. | <pre>list(object({<br>    name                   = string<br>    address_prefix         = string<br>    next_hop_type          = string<br>    next_hop_in_ip_address = optional(string)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_objects"></a> [objects](#output\_objects) | Route resource objects. |

# Usage

```
module "route-table-route" {
  source = "github.com/ItayMayo/terraform-modules//network/route-table/route-table-routes"

  # Configuration
  resource_group_name = "my-rg"
  route_table_name    = "my-route-table"
  route_table_routes  = route

  depends_on = [
    route-table,
  ]
}

```
<!-- END_TF_DOCS -->