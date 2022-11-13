# Usage

```
module "private-dns" {
  source = "github.com/ItayMayo/terraform-modules//private-dns"

  resource_group_name = "my-rg"

  zone_name = "zone.name"
  vnet_ids  = ["ids"]
}

```