locals {
  origin_target_suffix = "origin_target"
  target_origin_suffix = "target_origin"
}

resource "azurerm_virtual_network_peering" "peering_1_2" {
  name                      = "${var.name}_${local.origin_target_suffix}"
  resource_group_name       = var.origin_resource_group_name
  virtual_network_name      = var.origin_vnet_name
  remote_virtual_network_id = var.target_vnet_id

  allow_forwarded_traffic = var.allow_forwarded_traffic
  allow_gateway_transit   = var.allow_gateway_transit
  use_remote_gateways     = var.use_remote_gateways
}

resource "azurerm_virtual_network_peering" "peering_2_1" {
  name                      = "${var.name}_${local.target_origin_suffix}"
  resource_group_name       = var.target_resource_group_name
  virtual_network_name      = var.target_vnet_name
  remote_virtual_network_id = var.origin_vnet_id

  allow_forwarded_traffic = var.allow_forwarded_traffic
  allow_gateway_transit   = var.allow_gateway_transit
  use_remote_gateways     = var.use_remote_gateways
}
