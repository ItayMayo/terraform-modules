<!-- BEGIN_TF_DOCS -->
# Private Endpoint Module

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~>3.30.0 |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_endpoint_ip_address"></a> [endpoint\_ip\_address](#input\_endpoint\_ip\_address) | (Optional) Private IP Address to associate with this Private Endpoint. | `string` | `null` | no |
| <a name="input_is_manual_connection"></a> [is\_manual\_connection](#input\_is\_manual\_connection) | (Optional) Is the connection a manual connection. Default: false. | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Location of the resource. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) Private Endpoint name. | `string` | n/a | yes |
| <a name="input_private_endpoint_subnet_id"></a> [private\_endpoint\_subnet\_id](#input\_private\_endpoint\_subnet\_id) | (Required) ID of the subnet in which to create a Private Endpoint. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Name of the parent Resource Group. | `string` | n/a | yes |
| <a name="input_subresource_names"></a> [subresource\_names](#input\_subresource\_names) | (Required) Name of the subresources to associate this endpoint with. | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Required) Tags assigned to the resource. | `map(string)` | `null` | no |
| <a name="input_target_resource_id"></a> [target\_resource\_id](#input\_target\_resource\_id) | (Required) ID of the Resource to associate with this private endpoint. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Private Endpoint resource id. |
| <a name="output_name"></a> [name](#output\_name) | Private Endpoint resource name. |
| <a name="output_object"></a> [object](#output\_object) | Private Endpoint resource object. |

# Usage

```
module "private_endpoint" {
  source = "github.com/ItayMayo/terraform-modules//private-endpoint"

  location                   = "westeurope"
  resource_group_name        = "rg_name"
  name                       = "test-endpoint"
  private_endpoint_subnet_id = subnet_id
  endpoint_ip_address        = "192.166.0.66"
  subresource_names          = ["name"]
  target_resource_id         = resource.id

  depends_on = [
    resource
  ]
}

```
<!-- END_TF_DOCS -->