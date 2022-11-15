/**
* # Virtual Network Peering
*/

locals {
  origin_target_suffix = "origin-target"
  target_origin_suffix = "target-origin"
}

resource "azurerm_virtual_network_peering" "peering_origin_target" {
  name                      = "${var.name}-${local.origin_target_suffix}"
  resource_group_name       = var.origin_resource_group_name
  virtual_network_name      = var.origin_vnet_name
  remote_virtual_network_id = var.target_vnet_id
  allow_forwarded_traffic   = var.allow_forwarded_traffic
  allow_gateway_transit     = var.allow_origin_gateway_transit
  use_remote_gateways       = var.allow_target_gateway_transit
}

resource "azurerm_virtual_network_peering" "peering_target_origin" {
  name                      = "${var.name}-${local.target_origin_suffix}"
  resource_group_name       = var.target_resource_group_name
  virtual_network_name      = var.target_vnet_name
  remote_virtual_network_id = var.origin_vnet_id
  allow_forwarded_traffic   = var.allow_forwarded_traffic
  allow_gateway_transit     = var.allow_target_gateway_transit
  use_remote_gateways       = var.allow_origin_gateway_transit
}
