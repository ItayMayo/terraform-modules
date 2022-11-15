resource "azurerm_resource_group" "test-rg" {
  name     = "itaym-test-rg"
  location = "West Europe"
}

locals {
  nsg = jsondecode(file("./nsg.json"))
}

module "test-nsg" {
  source = "../"

  nsg_name            = "test-security-group"
  location            = "westeurope"
  resource_group_name = azurerm_resource_group.test-rg.name

  nsg_security_rules = local.nsg["test-security-group"]

  tags = { test = "test" }
}
