/**
* # Gateway Module
*/

locals {
  gateway_ip_name               = "primary"
  gateway_active_active_ip_name = "seconday"
  gateway_p2s_ip_name           = "third"
  private_ip_allocation         = "Dynamic"
  aad_audience                  = "41b23e61-6c1e-4545-b367-cd054e0ed4b4"
  aad_tenant_base_address       = "https://login.microsoftonline.com"
  aad_issuer_base_address       = "https://sts.windows.net"
}

data "azurerm_client_config" "current" {}

locals {
  should_create_three_pips = var.enable_active_active && var.enable_point_to_site
  should_create_two_pips   = var.enable_active_active || var.enable_point_to_site
  number_of_pips           = local.should_create_three_pips ? 3 : (local.should_create_two_pips ? 2 : 1)

  pip_name_prefix       = "${var.name}-vng-pip"
  pip_allocation_method = "Static"
  pip_sku               = "Standard"
  pip_zones             = [1, 2, 3]
}

resource "azurerm_public_ip" "public_ip" {
  for_each = { for i in range(local.number_of_pips) : tostring(i) => tostring(i) }

  name                = "${pip_name_prefix}-${each.value}"
  resource_group_name = var.resource_group_name
  location            = var.location

  allocation_method = local.pip_allocation_method
  sku               = local.pip_sku
  zones             = local.pip_zones
  tags              = var.tags
}

resource "azurerm_virtual_network_gateway" "virtual_network_gateway" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  type     = var.type
  vpn_type = var.vpn_type

  active_active = var.enable_active_active
  enable_bgp    = var.enable_bgp
  sku           = var.sku
  generation    = var.sku_generation

  dynamic "ip_configuration" {
    for_each = azurerm_public_ip.public_ip["0"]

    content {
      name                          = local.gateway_ip_name
      public_ip_address_id          = ip_configuration.value["id"]
      private_ip_address_allocation = local.private_ip_allocation
      subnet_id                     = var.gateway_subnet_id
    }
  }

  dynamic "ip_configuration" {
    for_each = [try(azurerm_public_ip.public_ip["1"], [])]

    content {
      name                          = local.gateway_active_active_ip_name
      public_ip_address_id          = ip_configuration.value["id"]
      private_ip_address_allocation = local.private_ip_allocation
      subnet_id                     = var.gateway_subnet_id
    }
  }

  dynamic "ip_configuration" {
    for_each = [try(azurerm_public_ip.public_ip["2"], [])]

    content {
      name                          = local.gateway_p2s_ip_name
      public_ip_address_id          = ip_configuration.value["id"]
      private_ip_address_allocation = local.private_ip_allocation
      subnet_id                     = var.gateway_subnet_id
    }
  }

  dynamic "vpn_client_configuration" {
    for_each = var.enable_point_to_site ? [var.vpn_client_configuration] : []

    content {
      address_space        = vpn_client_configuration.value["address_space"]
      vpn_auth_types       = vpn_client_configuration.value["auth_types"]
      vpn_client_protocols = vpn_client_configuration.value["client_protocols"]

      aad_tenant   = contains(vpn_client_configuration.value["auth_types"], "AAD") ? "${local.aad_tenant_base_address}/${data.azurerm_client_config.current.tenant_id}/" : null
      aad_audience = contains(vpn_client_configuration.value["auth_types"], "AAD") ? local.aad_audience : null
      aad_issuer   = contains(vpn_client_configuration.value["auth_types"], "AAD") ? "${local.aad_issuer_base_address}/${data.azurerm_client_config.current.tenant_id}/" : null

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

  tags = var.tags

  depends_on = [
    azurerm_public_ip.public_ip,
    data.azurerm_client_config.current
  ]
}

locals {
  diagnostics_name               = "${var.name}-gateway-diagnostics"
  target_resource_id             = azurerm_virtual_network_gateway.virtual_network_gateway.id
  diagnostics_workspace_provided = var.log_workspace_id != null
}

module "diagnostics" {
  source   = "github.com/ItayMayo/terraform-modules//diagnostic-settings"
  for_each = local.diagnostics_workspace_provided ? [1] : []

  name                       = local.diagnostics_name
  target_resource_id         = local.target_resource_id
  log_analytics_workspace_id = var.log_workspace_id

  depends_on = [
    azurerm_virtual_network_gateway.virtual_network_gateway
  ]
}
