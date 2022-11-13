# Usage

```
module "network-interface" {
  source = "github.com/ItayMayo/terraform-modules//Network/network-interface"

  # Generic Resource Configuration 
  resource_group_name = "my-rg"
  location            = "westeurope"

  # Network Interface Configuration
  name                  = "my-nic"
  ip_configuration_name = "my-nic-ip"
  subnet_id             = "subnet-id"
}
```