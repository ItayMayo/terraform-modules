# Usage

```
module "diagnostics" {
  source = "github.com/ItayMayo/terraform-modules//diagnostic-settings"

  # Configuration
  name                       = "resource-diagnostics"
  target_resource_id         = "resource_id"
  log_analytics_workspace_id = "workspace-id"

  depends_on = [
    target_resource
  ]
}
```