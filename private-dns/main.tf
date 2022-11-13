/**
* # Private DNS Module
*/

resource "azurerm_private_dns_zone" "private_dns" {
  name                = var.zone_name
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

locals {
  zone_a_records_provided = var.zone_a_records != null
}

resource "azurerm_private_dns_a_record" "a_record" {
  for_each = local.zone_a_records_provided ? var.zone_a_records : {}

  name                = each.value["name"]
  zone_name           = azurerm_private_dns_zone.private_dns.name
  resource_group_name = var.resource_group_name
  ttl                 = each.value["ttl"]
  records             = each.value["records"]

  depends_on = [
    azurerm_private_dns_zone.private_dns
  ]
}

locals {
  dns_link_prefix = "dns_link_"
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_vnet_link" {
  for_each = var.vnet_ids

  name                  = "${local.dns_link_prefix}${each.key}"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns.name
  virtual_network_id    = each.value
  tags                  = var.tags

  depends_on = [
    azurerm_private_dns_zone.private_dns
  ]
}
