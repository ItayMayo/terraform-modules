resource "azurerm_resource_group" "test-rg" {
  name     = "itaym-test-rg"
  location = "West Europe"
}

locals {
  work_vnet_name   = "test-vnet"
  work_subnet_name = "default"
}

locals {
  firewall_collection_group = jsondecode(file("./policies.json"))

  network_collection_groups = {
    test = local.firewall_collection_group["network_rule_collection_group"]
  }

  application_collection_groups = {
    test = local.firewall_collection_group["application_rule_collection_group"]
  }
}

module "firewall-policy" {
  source = "../"

  location            = "westeurope"
  resource_group_name = azurerm_resource_group.test-rg.name

  firewall_policy_name          = "policy"
  network_collection_groups     = local.network_collection_groups
  application_collection_groups = local.application_collection_groups
}
