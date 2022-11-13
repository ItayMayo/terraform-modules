# Usage

```
module "log-analytics-workspace" {
  source = "github.com/ItayMayo/terraform-modules//analytics-workspace"

  # Generic Resource Initiation
  resource_group_name = "my-rg"
  location            = "westeurope"

  # Resource Configuration
  name = "My Workspace"
}
```