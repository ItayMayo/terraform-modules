data "azurerm_network_interface" "acr_nic" {
  for_each = local.create_private_endpoint ? { acr = "acr" } : {}

  name                = azurerm_private_endpoint.endpoint["acr_endpoint"].network_interface[0]["name"]
  resource_group_name = var.resource_group_name
}
