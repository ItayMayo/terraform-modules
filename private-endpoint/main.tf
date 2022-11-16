/**
* # Private Endpoint Module
*/

locals {
  ip_configuration_name = "internal"
}

resource "azurerm_private_endpoint" "endpoint" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = var.name
    private_connection_resource_id = var.target_resource_id
    is_manual_connection           = var.is_manual_connection
    subresource_names              = var.subresource_names
  }

  dynamic "ip_configuration" {
    for_each = var.endpoint_ip_address != null ? [var.endpoint_ip_address] : []

    content {
      name               = local.ip_configuration_name
      private_ip_address = var.endpoint_ip_address
      subresource_name   = var.subresource_names[0]
    }
  }

  tags = var.tags
}
