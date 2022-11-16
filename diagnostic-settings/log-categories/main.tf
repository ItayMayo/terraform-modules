/**
* # Log Categories Module
*/

data "azurerm_monitor_diagnostic_categories" "diagnostic_categories" {
  resource_id = var.resource_id
}
