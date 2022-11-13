# Usage

```
module "vm" {
  source = "github.com/ItayMayo/terraform-modules//virtual-machine"

  # Generic Resource Configuration
  resource_group_name = "my-rg"
  location            = "westeurope"
  
  # Virtual Machine Configuration
  vm_name                            = "my-vm"
  vm_admin_username                  = "empire"
  vm_admin_password                  = "empire"
  vm_disable_password_authentication = true
  nic_subnet_id                      = "id"
}
```