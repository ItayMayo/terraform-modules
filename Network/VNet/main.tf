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
  for_each = [for subnet_name, value in var.subnets : value.associate_nsg ? subnet_name : null]

  subnet_id                 = azurerm_subnet.subnets[each.value].id
  network_security_group_id = var.nsg_id
}

module "logger_module" {
  source = "github.com/ItayMayo/terraform-azure-logger"

  name                       = "Diagnostics"
  target_resource_id         = azurerm_virtual_network.vnet.id
  log_analytics_workspace_id = var.log_workspace_id
}
