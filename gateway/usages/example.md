# Usage

```
module "vpn-gateway" {
  source = "github.com/ItayMayo/terraform-modules//gateway"
 
  # Generic Resource Configuration
  resource_group_name = "my-rg"
  location            = local.location
  log_workspace_id    = module.log-analytics-workspace.id

  # Gateway Configuration
  gateway_name      = "my-vpn-gateway"
  gateway_subnet_id = GatewaySubnet

  enable_point_to_site     = false
}

```