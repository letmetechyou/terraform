output "key_vault_managed_hardware_security_module_role_assignment_output" {
  value = zipmap(values(azurerm_key_vault_managed_hardware_security_module_role_assignment.main)[*].name, values(azurerm_key_vault_managed_hardware_security_module_role_assignment.main)[*])
}

output "key_vault_managed_hardware_security_module_role_assignment_output_names" {
  value = { for key, value in azurerm_key_vault_managed_hardware_security_module_role_assignment.main : value.name => value }
}