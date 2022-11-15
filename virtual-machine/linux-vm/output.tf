output "id" {
  value       = azurerm_linux_virtual_machine.vm.id
  description = "ID of the Linux Virtual Machine."
}

output "name" {
  value       = azurerm_linux_virtual_machine.vm.name
  description = "Name of the Linux Virtual Machine."
}

output "object" {
  value       = azurerm_linux_virtual_machine.vm
  description = "Object of the Linux Virtual Machine."
}
