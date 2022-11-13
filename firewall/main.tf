/**
* # Firewall Module
*/

resource "azurerm_firewall_policy" "firewall_policy" {
  name                = var.firewall_policy_name
  resource_group_name = var.resource_group_name
  location            = var.location
}

locals {
  firewall_pip_name     = "${var.firewall_name}-pip"
  management_pip_name   = "${var.firewall_name}-management-pip"
  pip_allocation_method = "Static"
  pip_sku               = "Standard"
  pip_zones             = [1, 2, 3]
}

resource "azurerm_public_ip" "public_ip" {
  for_each = var.enable_tunneling ? toset([local.firewall_pip_name, local.management_pip_name]) : [local.firewall_pip_name]

  name                = each.value
  resource_group_name = var.resource_group_name
  location            = var.location

  allocation_method = local.pip_allocation_method
  sku               = local.pip_sku
  zones             = local.pip_zones

  tags = var.tags
}

locals {
  primary_ip_config_name    = "firewall-ip-configuration"
  management_ip_config_name = "management-ip-configuration"
}

resource "azurerm_firewall" "firewall" {
  name                = var.firewall_name
  location            = var.location
  resource_group_name = var.resource_group_name

  firewall_policy_id = azurerm_firewall_policy.firewall_policy.id
  dns_servers        = var.firewall_dns_servers
  zones              = var.firewall_zones

  sku_name = var.firewall_sku_name
  sku_tier = var.firewall_sku_tier

  ip_configuration {
    name                 = local.primary_ip_config_name
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.public_ip[local.firewall_pip_name].id
  }

  dynamic "management_ip_configuration" {
    for_each = var.enable_tunneling ? [azurerm_public_ip.public_ip[local.management_pip_name]] : []

    content {
      name                 = local.management_ip_config_name
      subnet_id            = var.management_subnet_id
      public_ip_address_id = management_ip_configuration.value["id"]
    }
  }

  tags = var.tags

  depends_on = [
    azurerm_firewall_policy.firewall_policy,
    azurerm_public_ip.public_ip
  ]
}

locals {
  network_collection_groups_provided = var.network_collection_groups != null
}

resource "azurerm_firewall_policy_rule_collection_group" "firewall_policy_network_collection_group" {
  for_each = local.network_collection_groups_provided ? var.network_collection_groups : {}

  name               = each.value["name"]
  firewall_policy_id = azurerm_firewall_policy.firewall_policy.id
  priority           = each.value["priority"]

  dynamic "network_rule_collection" {
    for_each = each.value["network_rule_collections"] != null ? each.value["network_rule_collections"] : []

    content {
      name     = network_rule_collection.value["name"]
      priority = network_rule_collection.value["priority"]
      action   = network_rule_collection.value["action"]

      dynamic "rule" {
        for_each = network_rule_collection.value["rule"]

        content {
          name                  = rule.value["name"]
          protocols             = rule.value["protocols"]
          source_addresses      = rule.value["source_addresses"]
          destination_addresses = rule.value["destination_addresses"]
          destination_ports     = rule.value["destination_ports"]
        }
      }
    }
  }

  depends_on = [
    azurerm_firewall_policy.firewall_policy
  ]
}

locals {
  application_collection_groups_provided = var.application_collection_groups != null
}

resource "azurerm_firewall_policy_rule_collection_group" "firewall_policy_application_collection_group" {
  for_each = local.application_collection_groups_provided ? var.application_collection_groups : {}

  name               = each.value["name"]
  firewall_policy_id = azurerm_firewall_policy.firewall_policy.id
  priority           = each.value["priority"]

  dynamic "application_rule_collection" {
    for_each = each.value["application_rule_collections"] != null ? each.value["application_rule_collections"] : []

    content {
      name     = application_rule_collection.value["name"]
      priority = application_rule_collection.value["priority"]
      action   = application_rule_collection.value["action"]

      dynamic "rule" {
        for_each = application_rule_collection.value["rule"]

        content {
          name              = rule.value["name"]
          source_addresses  = rule.value["source_addresses"]
          destination_fqdns = rule.value["destination_fqdns"]

          dynamic "protocols" {
            for_each = rule.value["protocols"]

            content {
              type = protocols.value["type"]
              port = protocols.value["port"]
            }
          }
        }
      }
    }
  }

  depends_on = [
    azurerm_firewall_policy.firewall_policy
  ]
}

locals {
  nat_collection_groups_provided = var.nat_collection_groups != null
}

resource "azurerm_firewall_policy_rule_collection_group" "firewall_policy_nat_collection_group" {
  for_each = local.nat_collection_groups_provided ? var.nat_collection_groups : {}

  name               = each.value["name"]
  firewall_policy_id = azurerm_firewall_policy.firewall_policy.id
  priority           = each.value["priority"]

  dynamic "nat_rule_collection" {
    for_each = each.value["nat_rule_collections"] != null ? each.value["nat_rule_collections"] : []

    content {
      name     = nat_rule_collection.value["name"]
      priority = nat_rule_collection.value["priority"]
      action   = nat_rule_collection.value["action"]

      dynamic "rule" {
        for_each = nat_rule_collection.value["rule"]

        content {
          name                = rule.value["name"]
          protocols           = rule.value["protocols"]
          source_addresses    = rule.value["source_addresses"]
          destination_address = rule.value["destination_address"]
          destination_ports   = rule.value["destination_ports"]
          translated_address  = rule.value["translated_address"]
          translated_port     = rule.value["translated_port"]
        }
      }
    }
  }

  depends_on = [
    azurerm_firewall_policy.firewall_policy
  ]
}


locals {
  diagnostics_name               = "${var.firewall_name}-firewall-diagnostics"
  target_resource_id             = azurerm_firewall.firewall.id
  diagnostics_workspace_provided = var.log_workspace_id != null
}

module "diagnostics" {
  source   = "github.com/ItayMayo/terraform-modules//diagnostic-settings"
  for_each = local.diagnostics_workspace_provided ? [1] : []

  name                       = local.diagnostics_name
  target_resource_id         = local.target_resource_id
  log_analytics_workspace_id = var.log_workspace_id

  depends_on = [
    azurerm_firewall.firewall
  ]
}
