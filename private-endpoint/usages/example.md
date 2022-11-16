# Usage

```
module "private_endpoint" {
  source = "github.com/ItayMayo/terraform-modules//private-endpoint"

  location                   = "westeurope"
  resource_group_name        = "rg_name"
  name                       = "test-endpoint"
  private_endpoint_subnet_id = subnet_id
  endpoint_ip_address        = "192.166.0.66"
  subresource_names          = ["name"]
  target_resource_id         = resource.id

  depends_on = [
    resource
  ]
}

```