# Usage

```
module "acr" {
  source = "github.com/ItayMayo/terraform-modules//acr"

  # Generic Resource Initiation
  resource_group_name = "my-rg"
  location            = "westeurope"

  #Optional. Log Workspace Analytics ID
  log_workspace_id    = "workspace-id"

  # ACR Configuration
  acr_name = "myacr"
  acr_sku  = "Standard"

  admin_enabled                 = false
  data_endpoint_enabled         = true

  # Access Link
  private_endpoint_subnet_id = "subnet_id"
  private_dns_zone_name      = "privatelink.azurecr.io"
}

```