# Usage

```
module "firewall" {
  source = "github.com/ItayMayo/terraform-modules//firewall"

  # Generic Resource Configuration
  resource_group_name = "my-rg"
  location            = "westeurope"
  log_workspace_id    = "workspace.id"

  # Firewall Configuration
  firewall_name        = "my-firewall"
  enable_tunneling     = true
  subnet_id            = AzureFirewallSubnet
  management_subnet_id = AzureFirewallManagementSubnet

  firewall_policy_name          = "my-policy"
  network_collection_groups     = groups

  tags = ["my", "tags"]
}

```