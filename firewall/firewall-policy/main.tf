/**
* # Firewall Policy
*/

resource "azurerm_firewall_policy" "firewall_policy" {
  name                = var.firewall_policy_name
  resource_group_name = var.resource_group_name
  location            = var.location
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
    azurerm_firewall_policy.firewall_policy,
    azurerm_firewall_policy_rule_collection_group.firewall_policy_network_collection_group
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
    azurerm_firewall_policy.firewall_policy,
    azurerm_firewall_policy_rule_collection_group.firewall_policy_application_collection_group
  ]
}
