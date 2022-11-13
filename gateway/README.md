<!-- BEGIN_TF_DOCS -->
# Gateway Module

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
| <a name="input_bgp_settings"></a> [bgp\_settings](#input\_bgp\_settings) | Optional. BGP configuration block. Required when enable\_bgp is true. | <pre>object({<br>    asn         = string<br>    peer_weight = string<br><br>    peering_addresses = object({<br>      ip_configuration_name = string<br>      apipa_addresses       = list(string)<br>    })<br>  })</pre> | `null` | no |
| <a name="input_enable_active_active"></a> [enable\_active\_active](#input\_enable\_active\_active) | Optional. Enable Gateway Active-Active. Default: true. | `bool` | `true` | no |
| <a name="input_enable_bgp"></a> [enable\_bgp](#input\_enable\_bgp) | Optional. Enable Gateway BGP. Default: false. | `bool` | `false` | no |
| <a name="input_enable_point_to_site"></a> [enable\_point\_to\_site](#input\_enable\_point\_to\_site) | Optional. Enable Point-To-Site connections. Default: false. | `bool` | `false` | no |
| <a name="input_gateway_subnet_id"></a> [gateway\_subnet\_id](#input\_gateway\_subnet\_id) | Required. ID of the Gateway Subnet. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Required. Location of the resource. | `string` | n/a | yes |
| <a name="input_log_workspace_id"></a> [log\_workspace\_id](#input\_log\_workspace\_id) | Optional. ID of the log analytics workspace where logs should be sent to. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Required. Name of the Gateway resource. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Required. Name of the parent Resource Group. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | Optional. SKU of the Gateway. Default: VpnGw2AZ. | `string` | `"VpnGw2AZ"` | no |
| <a name="input_sku_generation"></a> [sku\_generation](#input\_sku\_generation) | Optional. Generation of the Gateway SKU. Default: Generation2. | `string` | `"Generation2"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Optional. Tags assigned to the resource. | `map(string)` | `null` | no |
| <a name="input_type"></a> [type](#input\_type) | Required. Type of the Gateway Resource. Default: Vpn. | `string` | `"Vpn"` | no |
| <a name="input_vpn_client_configuration"></a> [vpn\_client\_configuration](#input\_vpn\_client\_configuration) | Optional. P2S configuration block. Required when enable\_point\_to\_site is true. | <pre>object({<br>    address_space         = list(string)<br>    auth_types            = list(string)<br>    client_protocols      = list(string)<br>    radius_server_address = optional(string)<br>    radius_server_secret  = optional(string)<br><br>    root_certificate = optional(object({<br>      name             = string<br>      public_cert_data = string<br>    }))<br><br>    revoked_certificate = optional(object({<br>      name       = string<br>      thumbprint = string<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_vpn_type"></a> [vpn\_type](#input\_vpn\_type) | Required. Type of the Gateway VPN. Default: RouteBased. | `string` | `"RouteBased"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | ID of the VNG resource. |
| <a name="output_name"></a> [name](#output\_name) | Name of the VNG resource. |
| <a name="output_object"></a> [object](#output\_object) | Object of the VNG resource. |

# Usage

```
module "vpn-gateway" {
  source = "github.com/ItayMayo/terraform-modules//gateway"

  # Generic Resource Configuration
  resource_group_name = "my-rg"
  location            = local.location
  log_workspace_id    = module.log-analytics-workspace.id

  # Gateway Configuration
  gateway_name      = "my-vpn-gateway"
  gateway_subnet_id = GatewaySubnet

  enable_point_to_site     = false
}

```
<!-- END_TF_DOCS -->