resource "azurerm_subnet" "subnet" {
  name                = var.subnet_name
  resource_group_name = var.resource_group_name

  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.address_prefixes
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = var.nsg_id
}

resource "azurerm_subnet_route_table_association" "route_table_association" {
  subnet_id      = azurerm_subnet.subnet.id
  route_table_id = var.route_table_id
}
