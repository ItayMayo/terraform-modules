# Usage

```
module "security-group" {
  source = "github.com/ItayMayo/terraform-modules//network/security-group"

  # Generic Resource Configuration
  location            = "westeurope"
  resource_group_name = "my-rg"

  # Security Group Configuration
  nsg_name           = "my-nsg"
  nsg_security_rules = rules
}
```