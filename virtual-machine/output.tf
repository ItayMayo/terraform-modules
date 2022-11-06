output "virtual_machine_id" {
  value       = azurerm_linux_virtual_machine.vm.id
  description = "Virtual Machine resource id."
}

output "virtual_machine_name" {
  value       = azurerm_linux_virtual_machine.vm.name
  description = "Virtual Machine resource name."
}

output "virtual_machine_object" {
  value       = azurerm_linux_virtual_machine.vm
  description = "Virtual Machine resource object."
}

output "vm_nic_object" {
  value       = module.vm-network-interface.nic_object
  description = "Network Interface resource object associated with the Virtual Machine."
}
