# Usage

```
module "storage-account" {
  source = "github.com/ItayMayo/terraform-modules//storage-account"

  # Generic Resource Configuration
  resource_group_name = "my-rg"
  location            = "westeurope"

  name                       = "mystorageaccount"
  private_endpoint_subnet_id = "id"
}
```