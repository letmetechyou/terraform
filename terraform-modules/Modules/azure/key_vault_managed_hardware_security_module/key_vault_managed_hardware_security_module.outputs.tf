output "key_vault_managed_hardware_security_module_output" {
  value = zipmap(values(azurerm_key_vault_managed_hardware_security_module.main)[*].name, values(azurerm_key_vault_managed_hardware_security_module.main)[*])
}

output "key_vault_managed_hardware_security_module_output_names" {
  value = { for key, value in azurerm_key_vault_managed_hardware_security_module.main : value.name => value }
}
