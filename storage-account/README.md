# Storage Account

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
| [azurerm_private_dns_a_record.a_record](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_endpoint.endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_storage_account.storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_kind"></a> [account\_kind](#input\_account\_kind) | Required. Storage Account kind. Default: StorageV2. | `string` | `"StorageV2"` | no |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | Required. Storage Accuont tier. Default: Standard. | `string` | `"Standard"` | no |
| <a name="input_allow_nested_items_to_be_public"></a> [allow\_nested\_items\_to\_be\_public](#input\_allow\_nested\_items\_to\_be\_public) | Optional. Allow Storage Account nested items to be accessible over the public network. Default: false. | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | Required. Location of the resource. | `string` | n/a | yes |
| <a name="input_log_workspace_id"></a> [log\_workspace\_id](#input\_log\_workspace\_id) | Optional. ID of the log analytics workspace where logs should be sent to. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Required. Storage Accuont name. | `string` | n/a | yes |
| <a name="input_network_rules"></a> [network\_rules](#input\_network\_rules) | Optional. Storage Account Network Rules. | <pre>list(object({<br>    default_action             = string<br>    bypass                     = list(string)<br>    ip_rules                   = list(string)<br>    virtual_network_subnet_ids = list(string)<br><br>    private_link_access = object({<br>      endpoint_resource_id = string<br>      endpoint_tenant_id   = string<br>    })<br>  }))</pre> | `null` | no |
| <a name="input_private_dns_zone_name"></a> [private\_dns\_zone\_name](#input\_private\_dns\_zone\_name) | Optional. Name of a Private DNS zone to be associated with the storage account. | `string` | `null` | no |
| <a name="input_private_endpoint_subnet_id"></a> [private\_endpoint\_subnet\_id](#input\_private\_endpoint\_subnet\_id) | Optional. ID of the subnet in which to create a private endpoint for this Storage Account. | `string` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Optional. Enable Storage Account public network access. Default: false. | `bool` | `false` | no |
| <a name="input_replication_type"></a> [replication\_type](#input\_replication\_type) | Required. Storage Account replication type. Default: GRS. | `string` | `"GRS"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Required. Name of the parent Resource Group. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Required. Tags assigned to the resource. | `map(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint_object"></a> [endpoint\_object](#output\_endpoint\_object) | Storage Account Private Endpoint resource object. |
| <a name="output_id"></a> [id](#output\_id) | Storage Account resource id. |
| <a name="output_name"></a> [name](#output\_name) | Storage Accuont resource name. |
| <a name="output_object"></a> [object](#output\_object) | Storage Accuont resource object. |
<!-- END_TF_DOCS -->