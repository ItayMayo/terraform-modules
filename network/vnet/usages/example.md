# Usage

```
module "hub-vnet" {
  source = "github.com/ItayMayo/terraform-modules//network/vnet"

  # Generic Resource Configuration
  resource_group_name = "my-rg"
  location            = "westeurope"

  # Virtual Network Configuration
  vnet_name     = "my-vnet"
  address_space = ["10.0.0.0/16"]
  subnets       = subnets
}
```