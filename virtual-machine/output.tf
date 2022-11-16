output "id" {
  value       = try(azurerm_linux_virtual_machine.vm["vm"].id, azurerm_windows_virtual_machine.vm["vm"].id)
  description = "Virtual Machine resource id."
}

output "name" {
  value       = try(azurerm_linux_virtual_machine.vm["vm"].name, azurerm_windows_virtual_machine.vm["vm"].name)
  description = "Virtual Machine resource name."
}

output "object" {
  value       = var.vm_os_name == "Linux" ? azurerm_linux_virtual_machine.vm["vm"] : azurerm_windows_virtual_machine.vm["vm"]
  description = "Virtual Machine resource object."
}

output "nic_object" {
  value       = module.vm-network-interface.object
  description = "Network Interface resource object associated with the Virtual Machine."
}

output "vm_os_name" {
  value       = var.vm_os_name
  description = "Name of the Operating System for the Virtual Machine."
}
