<!-- BEGIN_TF_DOCS -->
# Network Security Group Module

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
| <a name="input_location"></a> [location](#input\_location) | (Required) Location of the resource. | `string` | n/a | yes |
| <a name="input_log_workspace_id"></a> [log\_workspace\_id](#input\_log\_workspace\_id) | (Required) ID of the log analytics workspace where logs should be sent to. Set as null if not needed. | `string` | n/a | yes |
| <a name="input_nsg_name"></a> [nsg\_name](#input\_nsg\_name) | (Required) Security Group name. | `string` | n/a | yes |
| <a name="input_nsg_security_rules"></a> [nsg\_security\_rules](#input\_nsg\_security\_rules) | (Required) List of security rules to associate with this security group. | <pre>list(object({<br>    name                         = string<br>    priority                     = number<br>    direction                    = string<br>    access                       = string<br>    protocol                     = string<br>    source_port_range            = optional(string)<br>    source_port_ranges           = optional(list(string))<br>    destination_port_range       = optional(string)<br>    destination_port_ranges      = optional(list(string))<br>    source_address_prefix        = optional(string)<br>    source_address_prefixes      = optional(list(string))<br>    destination_address_prefix   = optional(string)<br>    destination_address_prefixes = optional(list(string))<br>  }))</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Name of the parent Resource Group. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Tags assigned to the resource. | `map(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | ID of the Security Group resource. |
| <a name="output_name"></a> [name](#output\_name) | Name of the Security Group resource. |
| <a name="output_object"></a> [object](#output\_object) | Object of the Security Group resource. |

# Usage

```
module "security-group" {
  source = "github.com/ItayMayo/terraform-modules//network/security-group"

  # Generic Resource Configuration
  location            = "westeurope"
  resource_group_name = "my-rg"

  # Security Group Configuration
  nsg_name           = "my-nsg"
  nsg_security_rules = rules
}
```
<!-- END_TF_DOCS -->