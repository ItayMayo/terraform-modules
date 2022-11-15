output "id" {
  value       = try(module.windows-vm["vm"].id, module.linux-vm["vm"].id)
  description = "Virtual Machine resource id."
}

output "name" {
  value       = try(module.windows-vm["vm"].name, module.linux-vm["vm"].name)
  description = "Virtual Machine resource name."
}

output "object" {
  value       = var.vm_os_name == "Windows" ? module.windows-vm["vm"].object : module.linux-vm["vm"].object
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
