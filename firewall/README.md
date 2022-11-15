<!-- BEGIN_TF_DOCS -->
# Firewall Module

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_diagnostics"></a> [diagnostics](#module\_diagnostics) | github.com/ItayMayo/terraform-modules//diagnostic-settings | n/a |
| <a name="module_firewall-policy"></a> [firewall-policy](#module\_firewall-policy) | ./firewall-policy | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_collection_groups"></a> [application\_collection\_groups](#input\_application\_collection\_groups) | (Optional) A map of Policy Rule Collection Groups containing Application Rule Collections. | <pre>map(object({<br>    name     = string<br>    priority = number<br><br>    application_rule_collections = list(object({<br>      name     = string<br>      priority = number<br>      action   = string<br><br>      rule = list(object({<br>        name = string<br><br>        protocols = list(object({<br>          type = string<br>          port = number<br>        }))<br><br>        source_addresses  = list(string)<br>        destination_fqdns = list(string)<br>      }))<br>    }))<br>  }))</pre> | `null` | no |
| <a name="input_enable_tunneling"></a> [enable\_tunneling](#input\_enable\_tunneling) | (Optional) Enable Firewall tunneling. Default: false. | `bool` | `false` | no |
| <a name="input_firewall_dns_servers"></a> [firewall\_dns\_servers](#input\_firewall\_dns\_servers) | (Optional) Firewall associated DNS servers. | `list(string)` | `null` | no |
| <a name="input_firewall_name"></a> [firewall\_name](#input\_firewall\_name) | (Required) Name of the Firewall resource. | `string` | n/a | yes |
| <a name="input_firewall_policy_id"></a> [firewall\_policy\_id](#input\_firewall\_policy\_id) | (Optional) Id of a Firewall Policy. Required if Policy Name is not specified. | `string` | `null` | no |
| <a name="input_firewall_policy_name"></a> [firewall\_policy\_name](#input\_firewall\_policy\_name) | (Optional) Name of the Firewall's policy. This creates a new policy and is required if Policy ID is not specified. | `string` | `null` | no |
| <a name="input_firewall_sku_name"></a> [firewall\_sku\_name](#input\_firewall\_sku\_name) | (Optional) Name of the Firewall's SKU. Default: AZFW\_VNet. | `string` | `"AZFW_VNet"` | no |
| <a name="input_firewall_sku_tier"></a> [firewall\_sku\_tier](#input\_firewall\_sku\_tier) | (Optional) Tier of the Firewall's SKU. Default: Standard | `string` | `"Standard"` | no |
| <a name="input_firewall_zones"></a> [firewall\_zones](#input\_firewall\_zones) | (Optional) Availability Zones where the Firewall should be deployed to. | `list(string)` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Location of the resource. | `string` | n/a | yes |
| <a name="input_log_workspace_id"></a> [log\_workspace\_id](#input\_log\_workspace\_id) | (Required) ID of the log analytics workspace where logs should be sent to. Set as null if not needed. | `string` | n/a | yes |
| <a name="input_management_subnet_id"></a> [management\_subnet\_id](#input\_management\_subnet\_id) | (Optional) Firewall Management Subnet ID. Should only be set if enable\_tunneling is true. | `string` | `null` | no |
| <a name="input_nat_collection_groups"></a> [nat\_collection\_groups](#input\_nat\_collection\_groups) | (Optional) A map of Policy Rule Collection Groups containing NAT Rule Collections. | <pre>map(object({<br>    name     = string<br>    priority = number<br><br>    nat_rule_collections = list(object({<br>      name     = string<br>      priority = number<br>      action   = string<br><br>      rule = list(object({<br>        name                = string<br>        protocols           = list(string)<br>        source_addresses    = list(string)<br>        destination_address = string<br>        destination_ports   = list(string)<br>        translated_address  = string<br>        translated_port     = string<br>      }))<br>    }))<br>  }))</pre> | `null` | no |
| <a name="input_network_collection_groups"></a> [network\_collection\_groups](#input\_network\_collection\_groups) | (Optional) A map of Policy Rule Collection Groups containing Network Rule Collections. | <pre>map(object({<br>    name     = string<br>    priority = number<br><br>    network_rule_collections = list(object({<br>      name     = string<br>      priority = number<br>      action   = string<br><br>      rule = list(object({<br>        name                  = string<br>        protocols             = list(string)<br>        source_addresses      = list(string)<br>        destination_addresses = list(string)<br>        destination_ports     = list(string)<br>      }))<br>    }))<br>  }))</pre> | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Name of the parent Resource Group. | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | (Required) Firewall Subnet ID. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Tags assigned to the resource. | `map(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | ID of the Firewall resource. |
| <a name="output_name"></a> [name](#output\_name) | Name of the Firewall resource. |
| <a name="output_object"></a> [object](#output\_object) | Object of the Firewall resource. |

# Usage

```
module "firewall" {
  source = "github.com/ItayMayo/terraform-modules//firewall"

  # Generic Resource Configuration
  resource_group_name = "my-rg"
  location            = "westeurope"
  log_workspace_id    = "workspace.id"

  # Firewall Configuration
  firewall_name        = "my-firewall"
  enable_tunneling     = true
  subnet_id            = AzureFirewallSubnet
  management_subnet_id = AzureFirewallManagementSubnet

  firewall_policy_name          = "my-policy"
  network_collection_groups     = groups

  tags = ["my", "tags"]
}

```
<!-- END_TF_DOCS -->