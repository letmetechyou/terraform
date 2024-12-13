output "linux_virtual_machine_output" {
  value = zipmap(values(azurerm_linux_virtual_machine.linux_virtual_machine)[*].name, values(azurerm_linux_virtual_machine.linux_virtual_machine)[*])
}

output "linux_virtual_machine_output_names" {
  value = { for key, value in azurerm_linux_virtual_machine.linux_virtual_machine : value.name => value }
}

output "network_interface" {
  value = module.network_interface.network_interface_output_names
}

# output "key_vault_data" {
# 	value = local.key_vault_data
# }

output "tls_private_key_data" {
  value = local.tls_private_key_data
}