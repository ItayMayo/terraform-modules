module "TableCreation" {
  source = "./modules/TableCreation"

  resource_group_name = var.resource_group_name
  resource_location   = var.resource_location

  for_each = var.route_tables

  table_name                    = each.value["table_name"]
  disable_bgp_route_propagation = each.value["disable_bgp_route_propagation"]
  table_routes                  = each.value["table_routes"]
}

module "TableAssociation" {
  source = "./modules/TableAssoication"

  for_each = var.table_association

  subnet_id      = each.value["subnet_id"]
  route_table_id = module.TableCreation[each.value["table_name"]].table_id
}
