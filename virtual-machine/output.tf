output "id" {
  value       = azurerm_linux_virtual_machine.vm.id
  description = "Virtual Machine resource id."
}

output "name" {
  value       = azurerm_linux_virtual_machine.vm.name
  description = "Virtual Machine resource name."
}

output "object" {
  value       = azurerm_linux_virtual_machine.vm
  description = "Virtual Machine resource object."
}

output "nic_object" {
  value       = module.vm-network-interface.nic_object
  description = "Network Interface resource object associated with the Virtual Machine."
}
