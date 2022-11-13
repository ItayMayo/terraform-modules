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