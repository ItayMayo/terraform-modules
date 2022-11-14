resource "azurerm_resource_group" "test-rg" {
  name     = "itaym-acr-test"
  location = "West Europe"
}

locals {
  work_vnet_name   = "test-vnet"
  work_subnet_name = "default"
}

module "log-analytics-workspace" {
  source = "github.com/ItayMayo/terraform-modules//analytics-workspace"

  name = "test-log-analytics"

  resource_group_name = azurerm_resource_group.test-rg.name
  location            = "westeurope"

  depends_on = [
    azurerm_resource_group.test-rg
  ]
}

module "vnet" {
  source = "github.com/ItayMayo/terraform-modules//network/vnet"

  vnet_name           = "test-vnet"
  resource_group_name = azurerm_resource_group.test-rg.name

  location         = "westeurope"
  log_workspace_id = module.log-analytics-workspace.id

  address_space = ["192.166.0.0/16"]

  subnets = {
    AzureFirewallSubnet = {
      subnet_name      = "AzureFirewallSubnet"
      address_prefixes = ["192.166.0.64/26"]
    }
    AzureFirewallManagementSubnet = {
      subnet_name      = "AzureFirewallManagementSubnet"
      address_prefixes = ["192.166.0.128/26"]
    }
  }

  depends_on = [
    azurerm_resource_group.test-rg,
    module.log-analytics-workspace
  ]
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

module "hub-firewall" {
  source = "../"

  firewall_name        = "test-firewall"
  firewall_policy_name = "test-firewall-policy"

  resource_group_name = azurerm_resource_group.test-rg.name
  location            = "westeurope"
  log_workspace_id    = module.log-analytics-workspace.id

  enable_tunneling     = true
  subnet_id            = module.vnet.subnet_ids["AzureFirewallSubnet"]
  management_subnet_id = module.vnet.subnet_ids["AzureFirewallManagementSubnet"]

  network_collection_groups     = local.network_collection_groups
  application_collection_groups = local.application_collection_groups

  depends_on = [
    azurerm_resource_group.test-rg,
    module.vnet
  ]
}
