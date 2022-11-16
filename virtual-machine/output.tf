output "id" {
  value       = local.vm_resource.id
  description = "Virtual Machine resource id."
}

output "name" {
  value       = local.vm_resource.name
  description = "Virtual Machine resource name."
}

output "object" {
  value       = local.vm_resource
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
