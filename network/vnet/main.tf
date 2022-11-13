/**
* # Virtual Network Module
*/

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
  nsg_id               = each.value["nsg_id"]
  route_table_id       = each.value["route_table_id"]

  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

locals {
  diagnostics_name   = "${var.vnet_name}-vnet-diagnostics"
  target_resource_id = azurerm_virtual_network.vnet.id
  diagnostics_workspace_provided = var.log_workspace_id != null
}

module "diagnostics" {
  source = "github.com/ItayMayo/terraform-modules//diagnostic-settings"
  for_each = local.diagnostics_workspace_provided ? [1] : []

  name                       = local.diagnostics_name
  target_resource_id         = local.target_resource_id
  log_analytics_workspace_id = var.log_workspace_id

  depends_on = [
    azurerm_virtual_network.vnet
  ]
}
