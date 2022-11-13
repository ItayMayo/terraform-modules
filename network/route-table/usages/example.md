# Usage
```
module "route-table" {
  source = "github.com/ItayMayo/terraform-modules//network/route-table"

  # Generic Resource Configuration
  location            = "westeurope"
  resource_group_name = "my-rg"

  route_table_name              = "route_table_name"
  disable_bgp_route_propagation = true
  route_table_routes            = routes
}
```