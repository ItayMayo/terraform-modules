# Usage

```
module "subnets" {
  source = "github.com/ItayMayo/terraform-modules//network/subnet"

  # Configuration
  resource_group_name  = "my-rg"
  virtual_network_name = "my-vnet"
  name                 = "my-subnet"
  address_prefixes     = ["10.0.0.0/24"]
  nsg_id               = "nsg_id"
  route_table_id       = "route_table_id"
}
```