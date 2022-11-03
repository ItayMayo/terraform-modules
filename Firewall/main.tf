resource "azurerm_firewall" "firewall" {
  name                = var.firewall_name
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  firewall_policy_id  = azurerm_firewall_policy.firewall_policy.id
  sku_name            = var.firewall_sku_name
  sku_tier            = var.firewall_sku_tier
  dns_servers         = var.firewall_dns_servers
  zones               = var.firewall_zones

  dynamic "ip_configuration" {
    for_each = [var.firewall_ip_configuration[0]]

    content {
      name                 = ip_configuration.value["name"]
      subnet_id            = ip_configuration.value["subnet_id"]
      public_ip_address_id = ip_configuration.value["public_ip_address_id"]
    }
  }

  dynamic "management_ip_configuration" {
    for_each = var.enable_tunneling ? [var.firewall_ip_configuration[1]] : []

    content {
      name                 = management_ip_configuration.value["name"]
      subnet_id            = management_ip_configuration.value["subnet_id"]
      public_ip_address_id = management_ip_configuration.value["public_ip_address_id"]
    }
  }
}

resource "azurerm_firewall_policy" "firewall_policy" {
  name                = var.firewall_policy_name
  resource_group_name = var.resource_group_name
  location            = var.resource_location
}

locals {
  diagnostics_name = "Firewall Diagnostics"
  cluster_id       = azurerm_kubernetes_cluster.cluster.id
}

module "diagnostics_module" {
  source = "github.com/ItayMayo/terraform-azure-logger"

  name                       = local.diagnostics_name
  target_resource_id         = local.cluster_id
  log_analytics_workspace_id = var.log_workspace_id
}
