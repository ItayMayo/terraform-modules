<!-- BEGIN_TF_DOCS -->
# Firewall Policy

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_collection_groups"></a> [application\_collection\_groups](#input\_application\_collection\_groups) | (Optional) A map of Policy Rule Collection Groups containing Application Rule Collections. | <pre>map(object({<br>    name     = string<br>    priority = number<br><br>    application_rule_collections = list(object({<br>      name     = string<br>      priority = number<br>      action   = string<br><br>      rule = list(object({<br>        name = string<br><br>        protocols = list(object({<br>          type = string<br>          port = number<br>        }))<br><br>        source_addresses  = list(string)<br>        destination_fqdns = list(string)<br>      }))<br>    }))<br>  }))</pre> | `null` | no |
| <a name="input_firewall_policy_name"></a> [firewall\_policy\_name](#input\_firewall\_policy\_name) | (Required) Name of the Firewall's policy. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) Location of the resource. | `string` | n/a | yes |
| <a name="input_nat_collection_groups"></a> [nat\_collection\_groups](#input\_nat\_collection\_groups) | (Optional) A map of Policy Rule Collection Groups containing NAT Rule Collections. | <pre>map(object({<br>    name     = string<br>    priority = number<br><br>    nat_rule_collections = list(object({<br>      name     = string<br>      priority = number<br>      action   = string<br><br>      rule = list(object({<br>        name                = string<br>        protocols           = list(string)<br>        source_addresses    = list(string)<br>        destination_address = string<br>        destination_ports   = list(string)<br>        translated_address  = string<br>        translated_port     = string<br>      }))<br>    }))<br>  }))</pre> | `null` | no |
| <a name="input_network_collection_groups"></a> [network\_collection\_groups](#input\_network\_collection\_groups) | (Optional) A map of Policy Rule Collection Groups containing Network Rule Collections. | <pre>map(object({<br>    name     = string<br>    priority = number<br><br>    network_rule_collections = list(object({<br>      name     = string<br>      priority = number<br>      action   = string<br><br>      rule = list(object({<br>        name                  = string<br>        protocols             = list(string)<br>        source_addresses      = list(string)<br>        destination_addresses = list(string)<br>        destination_ports     = list(string)<br>      }))<br>    }))<br>  }))</pre> | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Name of the parent Resource Group. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Firewall Policy id. |
| <a name="output_name"></a> [name](#output\_name) | Firewall Policy name. |
| <a name="output_object"></a> [object](#output\_object) | Firewall Policy object. |

# Usage

```
module "firewall-policy" {
  source = "./firewall-policy"

  location            = "westeurope"
  resource_group_name = var.resource_group_name

  firewall_policy_name          = "policy"
  network_collection_groups     = var.network_collection_groups
  application_collection_groups = var.application_collection_groups
  nat_collection_groups         = var.nat_collection_groups
}
```
<!-- END_TF_DOCS -->