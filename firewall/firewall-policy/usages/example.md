# Usage

```
module "firewall-policy" {
  source = "./firewall-policy"

  location            = "westeurope"
  resource_group_name = var.resource_group_name

  firewall_policy_name          = "policy"
  network_collection_groups     = var.network_collection_groups
  application_collection_groups = var.application_collection_groups
  nat_collection_groups         = var.nat_collection_groups
}
```