resource "azurerm_route" "route-table-route" {
  for_each = { for index, value in var.route_table_routes : index => value }

  resource_group_name = var.resource_group_name
  route_table_name    = var.route_table_name

  name                   = each.value["name"]
  address_prefix         = each.value["address_prefix"]
  next_hop_type          = each.value["next_hop_type"]
  next_hop_in_ip_address = each.value["next_hop_in_ip_address"]
}
