<!-- BEGIN_TF_DOCS -->
# Log Analytics Workspace Module

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_daily_quota_gb"></a> [daily\_quota\_gb](#input\_daily\_quota\_gb) | Optional. Daily quota in gb. Default: Unlimited. | `number` | `-1` | no |
| <a name="input_internet_ingestion_enabled"></a> [internet\_ingestion\_enabled](#input\_internet\_ingestion\_enabled) | Optional. Workspace ingestion through the internet. Default: true. | `bool` | `true` | no |
| <a name="input_internet_query_enabled"></a> [internet\_query\_enabled](#input\_internet\_query\_enabled) | Optional. Workspace query through the internet. Default: true. | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | Required. Location of the resource. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Required. Workspace name. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Required. Name of the parent Resource Group. | `string` | n/a | yes |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | Optional. Log retention in days. Default: 30. | `number` | `30` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | Optional. Workspace SKU. Default: PerGB2018. | `string` | `"PerGB2018"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Optional. Tags assigned to the resource. | `map(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Analytics Workspace resource id. |
| <a name="output_name"></a> [name](#output\_name) | Analytics Workspace resource name. |
| <a name="output_object"></a> [object](#output\_object) | Analytics Workspace resource object. |

# Usage

```
module "log-analytics-workspace" {
  source = "github.com/ItayMayo/terraform-modules//analytics-workspace"

  # Generic Resource Initiation
  resource_group_name = "my-rg"
  location            = "westeurope"

  # Resource Configuration
  name = "My Workspace"
}
```
<!-- END_TF_DOCS -->