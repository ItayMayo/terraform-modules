resource "azurerm_kubernetes_cluster" "cluster" {
  name                = var.cluster_name
  location            = var.resource_location
  resource_group_name = var.resource_group_name

  dns_prefix                    = var.dns_prefix
  private_cluster_enabled       = var.private_cluster_enabled
  public_network_access_enabled = var.public_network_access_enabled
  private_dns_zone_id           = var.private_dns_zone_id

  dynamic "default_node_pool" {
    for_each = [var.default_node_pool]

    content {
      name       = default_node_pool.value["name"]
      node_count = default_node_pool.value["node_count"]
      vm_size    = default_node_pool.value["vm_size"]

      os_sku                = default_node_pool.value["os_sku"]
      enable_node_public_ip = default_node_pool.value["enable_node_public_ip"]
      vnet_subnet_id        = default_node_pool.value["vnet_subnet_id"]

      enable_auto_scaling = default_node_pool.value["enable_auto_scaling"]
      max_count           = default_node_pool.value["max_count"]
      min_count           = default_node_pool.value["min_count"]
    }
  }

  dynamic "identity" {
    for_each = [var.identity]

    content {
      type         = identity.value["type"]
      identity_ids = identity.value["identity_ids"]
    }
  }

  dynamic "network_profile" {
    for_each = local.network_profile_provided ? [var.network_profile] : []

    content {
      network_plugin = network_profile.value["network_plugin"]
      network_mode   = network_profile.value["network_mode"]
      network_policy = network_profile.value["network_policy"]
    }
  }

  lifecycle {
    ignore_changes = [
      tags,
      oms_agent,
    ]
  }
}

module "logger_module" {
  source = "github.com/ItayMayo/terraform-azure-logger"

  name                       = "Diagnostics"
  target_resource_id         = azurerm_kubernetes_cluster.cluster.id
  log_analytics_workspace_id = var.log_workspace_id
}
