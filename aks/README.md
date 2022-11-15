<!-- BEGIN_TF_DOCS -->
# AKS Module

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aks-private-dns"></a> [aks-private-dns](#module\_aks-private-dns) | github.com/ItayMayo/terraform-modules//private-dns | n/a |
| <a name="module_diagnostics"></a> [diagnostics](#module\_diagnostics) | github.com/ItayMayo/terraform-modules//diagnostic-settings | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks_acr_ids"></a> [aks\_acr\_ids](#input\_aks\_acr\_ids) | (Optional) Ids of Azure Container Registries to assign to this cluster. | `map(string)` | `null` | no |
| <a name="input_aks_dns_prefix"></a> [aks\_dns\_prefix](#input\_aks\_dns\_prefix) | (Required) DNS prefix of the AKS cluster. | `string` | n/a | yes |
| <a name="input_aks_private_dns_zone_id"></a> [aks\_private\_dns\_zone\_id](#input\_aks\_private\_dns\_zone\_id) | (Optional) ID of the private dns zone associated with the cluster. | `string` | `null` | no |
| <a name="input_default_node_pool"></a> [default\_node\_pool](#input\_default\_node\_pool) | (Required) Default node pool block. If auto scaling is enabled, min\_count and max\_count must be set. Otherwise, node\_count must be set. | <pre>object({<br>    name                = string<br>    vm_size             = string<br>    enable_auto_scaling = optional(bool)<br>    node_count          = optional(number)<br>    os_sku              = optional(string)<br>    max_count           = optional(number)<br>    min_count           = optional(number)<br>    vnet_subnet_id      = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_identity"></a> [identity](#input\_identity) | (Optional) AKS Identity block. Default: SystemAssigned. | <pre>object({<br>    type         = string<br>    identity_ids = optional(list(string))<br>  })</pre> | <pre>{<br>  "type": "SystemAssigned"<br>}</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Location of the resource. | `string` | n/a | yes |
| <a name="input_log_workspace_id"></a> [log\_workspace\_id](#input\_log\_workspace\_id) | (Required) ID of the log analytics workspace where logs should be sent to. Set as null if not needed. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) Name of the AKS cluster. | `string` | n/a | yes |
| <a name="input_network_profile"></a> [network\_profile](#input\_network\_profile) | (Optional) AKS Network Profile. | <pre>object({<br>    network_plugin = string<br>    network_mode   = optional(string)<br>    network_policy = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_private_dns_vnets"></a> [private\_dns\_vnets](#input\_private\_dns\_vnets) | (Required) Map of Virtual Networks to associate with the AKS. Required when create\_private\_dns is enabled. | `map(string)` | n/a | yes |
| <a name="input_private_endpoint_subnet_id"></a> [private\_endpoint\_subnet\_id](#input\_private\_endpoint\_subnet\_id) | (Required) ID of the subnet in which to create a private endpoint for this AKS. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Name of the parent Resource Group. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Tags assigned to the resource. | `map(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_certificate"></a> [client\_certificate](#output\_client\_certificate) | AKS cluster resource client certificate. |
| <a name="output_id"></a> [id](#output\_id) | AKS cluster resource id. |
| <a name="output_kube_config"></a> [kube\_config](#output\_kube\_config) | AKS cluster resource kube config. |
| <a name="output_name"></a> [name](#output\_name) | AKS cluster resource name. |
| <a name="output_object"></a> [object](#output\_object) | AKS cluster resource object. |
| <a name="output_private_dns_record_name"></a> [private\_dns\_record\_name](#output\_private\_dns\_record\_name) | Private DNS A record name. |

# Usage

```
module "aks" {
  source = "github.com/ItayMayo/terraform-modules//aks"

  # Generic Resource Initiation
  resource_group_name = "my-rg"
  location            = "westeurope"

  #(Optional) Log Workspace Analytics ID
  log_workspace_id    = "workspace-id"

  #Cluster Initiation
  cluster_name = "my-cluster"
  dns_prefix   = "my-cluster"

  # Default node pool config.
  default_node_pool = {
    name    = "default-pool"

    enable_auto_scaling   = false
    node_count = 2
  }

  # Cluster Network Plugin
  network_profile = {
    network_plugin = local.aks_network_plugin
  }

  private_endpoint_subnet_id = "private_endpoint_subnet_id"
  aks_acr_ids                = ["my", "acr", "id"]

  tags = ["my", "tags"]
}

```
<!-- END_TF_DOCS -->