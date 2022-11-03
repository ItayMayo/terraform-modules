resource "azurerm_private_endpoint" "endpoint" {
  name                = var.endpoint_name
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = var.service_connection_name
    private_connection_resource_id = var.service_connection_resource_id
    is_manual_connection           = var.service_connection_is_manual_connection
    subresource_names              = var.subresource_name
  }

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}
