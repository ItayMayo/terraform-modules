resource "azurerm_subnet" "subnet" {
  name                = var.subnet_name
  resource_group_name = var.resource_group_name

  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.address_prefixes
}

locals {
  nsg_provided = var.nsg_id != null
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  for_each = local.nsg_provided ? [1] : []

  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = var.nsg_id
}

locals {
  route_table_provided = var.route_table_id != null
}

resource "azurerm_subnet_route_table_association" "route_table_association" {
  for_each = local.route_table_provided ? [1] : []

  subnet_id      = azurerm_subnet.subnet.id
  route_table_id = var.route_table_id
}
