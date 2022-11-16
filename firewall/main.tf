/**
* # Firewall Module
*/

module "firewall-policy" {
  source = "./firewall-policy"

  for_each = var.firewall_policy_id == null ? { policy = "policy" } : {}

  location                      = var.location
  resource_group_name           = var.resource_group_name
  firewall_policy_name          = var.firewall_policy_name
  network_collection_groups     = var.network_collection_groups
  application_collection_groups = var.application_collection_groups
  nat_collection_groups         = var.nat_collection_groups
}

locals {
  firewall_pip_name     = "${var.firewall_name}-pip"
  management_pip_name   = "${var.firewall_name}-management-pip"
  pip_allocation_method = "Static"
  pip_sku               = "Standard"
  pip_zones             = [1, 2, 3]
}

resource "azurerm_public_ip" "public_ip" {
  for_each = var.enable_tunneling ? toset([local.firewall_pip_name, local.management_pip_name]) : [local.firewall_pip_name]

  name                = each.value
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = local.pip_allocation_method
  sku                 = local.pip_sku
  zones               = local.pip_zones
  tags                = var.tags
}

locals {
  primary_ip_config_name    = "firewall-ip-configuration"
  management_ip_config_name = "management-ip-configuration"
}

resource "azurerm_firewall" "firewall" {
  name                = var.firewall_name
  location            = var.location
  resource_group_name = var.resource_group_name
  firewall_policy_id  = var.firewall_policy_id != null ? var.firewall_policy_id : module.firewall-policy["policy"].id
  dns_servers         = var.firewall_dns_servers
  zones               = var.firewall_zones
  sku_name            = var.firewall_sku_name
  sku_tier            = var.firewall_sku_tier

  ip_configuration {
    name                 = local.primary_ip_config_name
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.public_ip[local.firewall_pip_name].id
  }

  dynamic "management_ip_configuration" {
    for_each = var.enable_tunneling ? [azurerm_public_ip.public_ip[local.management_pip_name]] : []

    content {
      name                 = local.management_ip_config_name
      subnet_id            = var.management_subnet_id
      public_ip_address_id = management_ip_configuration.value["id"]
    }
  }

  tags = var.tags

  depends_on = [
    module.firewall-policy,
    azurerm_public_ip.public_ip
  ]
}

locals {
  diagnostics_name               = "${var.firewall_name}-firewall-diagnostics"
  diagnostics_workspace_provided = var.log_workspace_id != null
}

module "diagnostics" {
  source   = "github.com/ItayMayo/terraform-modules//diagnostic-settings"
  for_each = local.diagnostics_workspace_provided ? { "1" : "1" } : {}

  name                       = local.diagnostics_name
  target_resource_id         = azurerm_firewall.firewall.id
  log_analytics_workspace_id = var.log_workspace_id

  depends_on = [
    azurerm_firewall.firewall
  ]
}
