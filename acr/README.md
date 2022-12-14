<!-- BEGIN_TF_DOCS -->
# ACR Module

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_diagnostics"></a> [diagnostics](#module\_diagnostics) | github.com/ItayMayo/terraform-modules//diagnostic-settings | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_enabled"></a> [admin\_enabled](#input\_admin\_enabled) | (Optional) Enable admin account. Default: false. | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Location of the resource. | `string` | n/a | yes |
| <a name="input_log_workspace_id"></a> [log\_workspace\_id](#input\_log\_workspace\_id) | (Required) ID of the log analytics workspace where logs should be sent to. Set as null if not needed. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) Name of the Container Registry. | `string` | n/a | yes |
| <a name="input_private_dns_zone_name"></a> [private\_dns\_zone\_name](#input\_private\_dns\_zone\_name) | (Required) Name of a Private DNS zone to be associated with the ACR. | `string` | n/a | yes |
| <a name="input_private_endpoint_subnet_id"></a> [private\_endpoint\_subnet\_id](#input\_private\_endpoint\_subnet\_id) | (Required) ID of the subnet in which to create a private endpoint for this ACR. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Name of the parent Resource Group. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | (Required) Container Registry SKU name. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Tags assigned to the resource. | `map(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | ACR resource id. |
| <a name="output_name"></a> [name](#output\_name) | ACR resource name. |
| <a name="output_object"></a> [object](#output\_object) | ACR resource object. |

# Usage

```
module "acr" {
  source = "github.com/ItayMayo/terraform-modules//acr"

  # Generic Resource Initiation
  resource_group_name = "my-rg"
  location            = "westeurope"

  #(Optional) Log Workspace Analytics ID
  log_workspace_id    = "workspace-id"

  # ACR Configuration
  acr_name = "myacr"
  acr_sku  = "Standard"

  admin_enabled                 = false
  data_endpoint_enabled         = true

  # Access Link
  private_endpoint_subnet_id = "subnet_id"
  private_dns_zone_name      = "privatelink.azurecr.io"
}

```
<!-- END_TF_DOCS -->