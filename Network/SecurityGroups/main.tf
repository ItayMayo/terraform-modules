module "GroupCreation" {
  source = "./modules/GroupCreation"

  resource_group_name = var.resource_group_name
  resource_location   = var.resource_location

  for_each = var.security_groups

  nsg_name           = each.value["nsg_name"]
  nsg_security_rules = each.value["nsg_security_rules"]
}

module "GroupAssociation" {
  source = "./modules/GroupAssociation"

  for_each = var.group_association

  subnet_id = each.value["subnet_id"]
  nsg_id    = module.GroupCreation[each.value["nsg_name"]].nsg_id
}
