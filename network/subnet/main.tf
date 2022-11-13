/**
* # Subnet Module 
*/

resource "azurerm_subnet" "subnet" {
  name                = var.name
  resource_group_name = var.resource_group_name

  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.address_prefixes
}

locals {
  nsg_provided = var.nsg_id != null
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  for_each = local.nsg_provided ? { nsg = var.nsg_id } : {}

  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = each.value
}

locals {
  route_table_provided = var.route_table_id != null
}

resource "azurerm_subnet_route_table_association" "route_table_association" {
  for_each = local.route_table_provided ? { route_table = var.route_table_id } : {}

  subnet_id      = azurerm_subnet.subnet.id
  route_table_id = each.value
}
