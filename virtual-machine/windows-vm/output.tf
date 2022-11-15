output "id" {
  value       = azurerm_windows_virtual_machine.vm.id
  description = "ID of the Windows Virtual Machine."
}

output "name" {
  value       = azurerm_windows_virtual_machine.vm.name
  description = "Name of the Windows Virtual Machine."
}

output "object" {
  value       = azurerm_windows_virtual_machine.vm
  description = "Object of the Windows Virtual Machine."
}
