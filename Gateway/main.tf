resource "azurerm_virtual_network_gateway" "vng" {
  name                = var.gateway_name
  location            = var.resource_location
  resource_group_name = var.resource_group_name

  type     = var.gateway_type
  vpn_type = var.gateway_vpn_type

  active_active = var.enable_active_active
  enable_bgp    = var.enable_bgp
  sku           = var.gateway_sku
  generation    = var.gateway_sku_generation

  dynamic "ip_configuration" {
    for_each = [var.ip_configuration[0]]

    content {
      name                          = ip_configuration.value["name"]
      public_ip_address_id          = ip_configuration.value["public_ip_address_id"]
      private_ip_address_allocation = ip_configuration.value["private_ip_address_allocation"]
      subnet_id                     = ip_configuration.value["subnet_id"]
    }
  }

  dynamic "ip_configuration" {
    for_each = var.enable_active_active ? [var.ip_configuration[1]] : []

    content {
      name                          = ip_configuration.value["name"]
      public_ip_address_id          = ip_configuration.value["public_ip_address_id"]
      private_ip_address_allocation = ip_configuration.value["private_ip_address_allocation"]
      subnet_id                     = ip_configuration.value["subnet_id"]
    }
  }

  dynamic "ip_configuration" {
    for_each = var.enable_point_to_site ? [var.ip_configuration[2]] : []

    content {
      name                          = ip_configuration.value["name"]
      public_ip_address_id          = ip_configuration.value["public_ip_address_id"]
      private_ip_address_allocation = ip_configuration.value["private_ip_address_allocation"]
      subnet_id                     = ip_configuration.value["subnet_id"]
    }
  }

  dynamic "vpn_client_configuration" {
    for_each = var.enable_point_to_site ? [var.vpn_client_configuration] : []

    content {
      address_space        = vpn_client_configuration.value["address_space"]
      vpn_auth_types       = vpn_client_configuration.value["auth_types"]
      vpn_client_protocols = vpn_client_configuration.value["client_protocols"]

      aad_tenant   = contains(vpn_client_configuration.value["auth_types"], "AAD") ? "https://login.microsoftonline.com/${data.azurerm_client_config.current.tenant_id}/" : null
      aad_audience = contains(vpn_client_configuration.value["auth_types"], "AAD") ? local.aad_audience : null
      aad_issuer   = contains(vpn_client_configuration.value["auth_types"], "AAD") ? "https://sts.windows.net/${data.azurerm_client_config.current.tenant_id}/" : null

      radius_server_address = vpn_client_configuration.value["radius_server_address"]
      radius_server_secret  = vpn_client_configuration.value["radius_server_secret"]

      dynamic "root_certificate" {
        for_each = vpn_client_configuration.value["root_certificate"] != null ? [vpn_client_configuration.value["root_certificate"]] : []

        content {
          name             = root_certificate.value["name"]
          public_cert_data = root_certificate.value["public_cert_data"]
        }
      }

      dynamic "revoked_certificate" {
        for_each = vpn_client_configuration.value["revoked_certificate"] != null ? [vpn_client_configuration.value["revoked_certificate"]] : []

        content {
          name       = revoked_certificate.value["name"]
          thumbprint = revoked_certificate.value["thumbprint"]
        }
      }
    }
  }

  dynamic "bgp_settings" {
    for_each = var.enable_bgp ? [var.bgp_settings] : []

    content {
      asn         = bgp_settings.value["asn"]
      peer_weight = bgp_settings.value["peer_weight"]

      peering_addresses {
        ip_configuration_name = bgp_settings.value["peering_addresses"]["ip_configuration_name"]
        apipa_addresses       = bgp_settings.value["peering_addresses"]["apipa_addresses"]
      }
    }
  }

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

module "logger_module" {
  source = "github.com/ItayMayo/terraform-azure-logger"

  name                       = "Diagnostics"
  target_resource_id         = azurerm_virtual_network_gateway.vng.id
  log_analytics_workspace_id = var.log_workspace_id
}
