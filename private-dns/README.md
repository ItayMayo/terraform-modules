<!-- BEGIN_TF_DOCS -->
# Private DNS Module

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
| <a name="input_tags"></a> [tags](#input\_tags) | Required. Tags assigned to the resource. | `map(string)` | `null` | no |
| <a name="input_vnet_ids"></a> [vnet\_ids](#input\_vnet\_ids) | Required. DNS Zone associated vnet ids. | `map(string)` | n/a | yes |
| <a name="input_zone_a_records"></a> [zone\_a\_records](#input\_zone\_a\_records) | Optional. DNS Zone A records. | <pre>map(object({<br>    name    = string<br>    ttl     = number<br>    records = list(string)<br>  }))</pre> | `null` | no |
| <a name="input_zone_name"></a> [zone\_name](#input\_zone\_name) | Required. Name of the DNS zone. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Private DNS resource id. |
| <a name="output_name"></a> [name](#output\_name) | Private DNS resource name. |
| <a name="output_object"></a> [object](#output\_object) | Private DNS resource object. |

# Usage

```
module "private-dns" {
  source = "github.com/ItayMayo/terraform-modules//private-dns"

  resource_group_name = "my-rg"

  zone_name = "zone.name"
  vnet_ids  = ["ids"]
}

```
<!-- END_TF_DOCS -->