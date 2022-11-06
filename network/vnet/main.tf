resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  address_space = var.address_space
  dns_servers   = var.dns_servers
}

resource "azurerm_subnet" "subnets" {
  for_each = var.subnets

  name                = each.value["subnet_name"]
  resource_group_name = var.resource_group_name

  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = each.value["address_prefixes"]
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  for_each = [for subnet_name, value in var.subnets : value.nsg_id != null ? value : null]

  subnet_id                 = azurerm_subnet.subnets[each.value["subnet_name"]].id
  network_security_group_id = each.value["nsg_id"]
}

resource "azurerm_subnet_route_table_association" "route_table_association" {
  for_each = [for subnet_name, value in var.subnets : value.route_table_id != null ? value : null]

  subnet_id      = azurerm_subnet.subnets[each.value["subnet_name"]].id
  route_table_id = each.value["route_table_id"]
}

locals {
  diagnostics_name   = "Virtual Network Diagnostics"
  target_resource_id = azurerm_virtual_network.vnet.id
}

module "diagnostics_module" {
  source = "github.com/ItayMayo/terraform-modules/tree/master/diagnostic-settings"

  name                       = local.diagnostics_name
  target_resource_id         = local.resource_id
  log_analytics_workspace_id = var.log_workspace_id
}
