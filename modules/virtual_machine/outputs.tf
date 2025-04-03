output "vm_id" {
  value = azurerm_linux_virtual_machine.vm.id
  description = "The ID of the VM"
}

output "private_ip_address" {
  value = azurerm_linux_virtual_machine.vm.private_ip_address
  description = "The private IP address of the VM"
}
