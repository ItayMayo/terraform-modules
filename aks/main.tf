locals {
  network_profile_provided = var.network_profile != null
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

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
}

locals {
  create_private_endpoint = var.private_endpoint_subnet_id != null
  endpoint_name           = "${azurerm_kubernetes_cluster.cluster.name}-private-endpoint"
  is_manual_connection    = false
  subresource_names       = ["management"]
}

resource "azurerm_private_endpoint" "endpoint" {
  for_each = local.create_private_endpoint ? { aks_endpoint = var.private_endpoint_subnet_id } : {}

  name                = local.endpoint_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = each.value
  tags                = var.tags

  private_service_connection {
    name                           = local.endpoint_name
    private_connection_resource_id = azurerm_kubernetes_cluster.cluster.id
    is_manual_connection           = local.is_manual_connection
    subresource_names              = local.subresource_names
  }
}

locals {
  dns_record_ttl      = 300
  aks_dns_zone_name   = join(".", slice(split(".", azurerm_kubernetes_cluster.cluster.private_fqdn), 1, length(split(".", azurerm_kubernetes_cluster.cluster.private_fqdn))))
  aks_dns_record_name = split(".", azurerm_kubernetes_cluster.cluster.private_fqdn)[0]
}

module "aks-private-dns" {
  source = "github.com/ItayMayo/terraform-modules//private-dns"

  for_each = var.create_private_dns ? { aks_dns = "aks_dns" } : {}

  resource_group_name = var.resource_group_name

  zone_name = local.aks_dns_zone_name
  vnet_ids  = var.private_dns_vnets
  tags      = var.tags

  zone_a_records = {
    storage_account = {
      name    = local.aks_dns_record_name
      ttl     = local.dns_record_ttl
      records = [azurerm_private_endpoint.endpoint["aks_endpoint"].private_service_connection[0].private_ip_address]
    }
  }

  depends_on = [
    azurerm_private_endpoint.endpoint
  ]
}

locals {
  acr_ids_provided = var.aks_acr_ids != null
}

resource "azurerm_role_assignment" "aks-role-assignment" {
  for_each = local.acr_ids_provided ? var.aks_acr_ids : {}

  role_definition_name             = "AcrPull"
  principal_id                     = azurerm_kubernetes_cluster.cluster.kubelet_identity[0].object_id
  scope                            = each.value
  skip_service_principal_aad_check = true

  depends_on = [
    azurerm_kubernetes_cluster.cluster
  ]
}


locals {
  diagnostics_name = "aks-diagnostics"
  cluster_id       = azurerm_kubernetes_cluster.cluster.id
}

module "diagnostics" {
  source = "github.com/ItayMayo/terraform-modules//diagnostic-settings"

  name                       = local.diagnostics_name
  target_resource_id         = local.cluster_id
  log_analytics_workspace_id = var.log_workspace_id

  depends_on = [
    azurerm_kubernetes_cluster.cluster
  ]
}
