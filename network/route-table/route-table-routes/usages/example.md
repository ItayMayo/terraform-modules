# Usage

```
module "route-table-route" {
  source = "github.com/ItayMayo/terraform-modules//network/route-table/route-table-routes"

  # Configuration
  resource_group_name = "my-rg"
  route_table_name    = "my-route-table"
  route_table_routes  = route

  depends_on = [
    route-table,
  ]
}

```