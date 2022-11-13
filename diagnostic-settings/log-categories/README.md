<!-- BEGIN_TF_DOCS -->
# Log Categories Module

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource_id"></a> [resource\_id](#input\_resource\_id) | (Required) Resource ID. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_diagnostic_category_groups"></a> [diagnostic\_category\_groups](#output\_diagnostic\_category\_groups) | n/a |
| <a name="output_diagnostic_category_types"></a> [diagnostic\_category\_types](#output\_diagnostic\_category\_types) | n/a |
| <a name="output_diagnostic_metrics_categories"></a> [diagnostic\_metrics\_categories](#output\_diagnostic\_metrics\_categories) | n/a |
| <a name="output_object"></a> [object](#output\_object) | n/a |

# Usage

```
module "log-categories" {
  source = "./log-categories"

  resource_id = "id"
}

```
<!-- END_TF_DOCS -->