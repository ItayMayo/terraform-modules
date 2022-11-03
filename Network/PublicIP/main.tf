resource "azurerm_public_ip" "public_ip" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.resource_location

  allocation_method = var.allocation_method
  sku               = var.sku
  zones             = var.zones

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}
