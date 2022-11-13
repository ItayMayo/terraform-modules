# Usage

```
module "vnet-peering" {
  source = "github.com/ItayMayo/terraform-modules//network/vnet-peer"

  name = "my-peering"

  origin_resource_group_name = "my-rg1"
  target_resource_group_name = "my-rg2"

  origin_vnet_name = "origin_vnet_name"
  target_vnet_name = "target_vnet_name"
  origin_vnet_id   = "origin_vnet_id"
  target_vnet_id   = "target_vnet_id"
}
```