/**
* # Virtual Network Module
*/

locals {
  nsg_provided = var.security_groups != null
}

module "network-security-groups" {
  source = "github.com/ItayMayo/terraform-modules//network/security-group"

  for_each = local.nsg_provided ? var.security_groups : {}

  nsg_name            = each.key
  location            = var.location
  resource_group_name = var.resource_group_name

  nsg_security_rules = each.value

  tags = var.tags
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location

  address_space = var.address_space
  dns_servers   = var.dns_servers

  tags = var.tags
}

module "subnets" {
  source = "github.com/ItayMayo/terraform-modules//network/subnet"

  for_each = var.subnets

  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  name                 = each.value["subnet_name"]
  address_prefixes     = each.value["address_prefixes"]
  nsg_id               = each.value["nsg_name"] != null ? try(module.network-security-groups[each.value["nsg_name"]].id, null) : null
  route_table_id       = each.value["route_table_id"]

  depends_on = [
    azurerm_virtual_network.vnet,
    module.network-security-groups
  ]
}

locals {
  diagnostics_name               = "${var.vnet_name}-vnet-diagnostics"
  target_resource_id             = azurerm_virtual_network.vnet.id
  diagnostics_workspace_provided = var.log_workspace_id != null
}

module "diagnostics" {
  source   = "github.com/ItayMayo/terraform-modules//diagnostic-settings"
  for_each = local.diagnostics_workspace_provided ? { "1" : "1" } : {}

  name                       = local.diagnostics_name
  target_resource_id         = local.target_resource_id
  log_analytics_workspace_id = var.log_workspace_id

  depends_on = [
    azurerm_virtual_network.vnet
  ]
}
