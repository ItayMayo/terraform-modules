/**
* # Subnet Module 
*/

resource "azurerm_subnet" "subnet" {
  name                 = var.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.address_prefixes
}

locals {
  nsg_provided = var.nsg_id != null
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  count = local.nsg_provided ? 1 : 0

  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = var.nsg_id

  depends_on = [
    azurerm_subnet.subnet
  ]
}

locals {
  route_table_provided = var.route_table_id != null
}

resource "azurerm_subnet_route_table_association" "route_table_association" {
  count = local.route_table_provided ? 1 : 0

  subnet_id      = azurerm_subnet.subnet.id
  route_table_id = var.route_table_id

  depends_on = [
    azurerm_subnet.subnet
  ]
}
