resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  address_space = var.address_space
  dns_servers   = var.dns_servers
}

module "subnets" {
  source = "github.com/ItayMayo/terraform-modules//network/subnet"

  for_each = var.subnets

  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  subnet_name          = each.value["subnet_name"]
  address_prefixes     = each.value["address_prefixes"]
  nsg_id               = each.value["nsg_id"]
  route_table_id       = each.value["route_table_id"]
}

locals {
  diagnostics_name   = "Virtual Network Diagnostics"
  target_resource_id = azurerm_virtual_network.vnet.id
}

module "diagnostics" {
  source = "github.com/ItayMayo/terraform-modules//diagnostic-settings"

  name                       = local.diagnostics_name
  target_resource_id         = local.target_resource_id
  log_analytics_workspace_id = var.log_workspace_id
}
