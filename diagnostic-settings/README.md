# Diagnostic Settings

<!-- BEGIN_TF_DOCS -->
# Diagnostic Settings Module

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_log-categories"></a> [log-categories](#module\_log-categories) | ./log-categories | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_eventhub_authorization_rule_id"></a> [eventhub\_authorization\_rule\_id](#input\_eventhub\_authorization\_rule\_id) | Optional. ID of an Eventhub authorization rule. | `string` | `null` | no |
| <a name="input_eventhub_name"></a> [eventhub\_name](#input\_eventhub\_name) | Optional. Name of an Eventhub. | `string` | `null` | no |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | Optional. ID of the Log Analytics Workspace to store the logs in. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Required. Settings link name. | `string` | n/a | yes |
| <a name="input_retention_policy_days"></a> [retention\_policy\_days](#input\_retention\_policy\_days) | Optional. Number of days to retain logs. Default: Unlimited. | `number` | `null` | no |
| <a name="input_storage_account_id"></a> [storage\_account\_id](#input\_storage\_account\_id) | Optional. ID of the Storage Account to store the logs in. | `string` | `null` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | Optional. Subscription ID. Provide only when enabling Activity Logs. | `string` | `null` | no |
| <a name="input_target_resource_id"></a> [target\_resource\_id](#input\_target\_resource\_id) | Optional. ID of the resource to monitor. Provide only when Subscription ID is not specified. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | ID of the diagnostic\_settings resource. |
| <a name="output_object"></a> [object](#output\_object) | Object of the diagnostic\_settings resource. |

# Usage

```
module "diagnostics" {
  source = "github.com/ItayMayo/terraform-modules//diagnostic-settings"

  # Configuration
  name                       = "resource-diagnostics"
  target_resource_id         = "resource_id"
  log_analytics_workspace_id = "workspace-id"

  depends_on = [
    target_resource
  ]
}
```
<!-- END_TF_DOCS -->