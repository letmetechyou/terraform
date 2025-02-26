output "recovery_services_vault_output" {
  value = zipmap(values(azurerm_recovery_services_vault.recovery_services_vault)[*].name, values(azurerm_recovery_services_vault.recovery_services_vault)[*])
}

output "recovery_services_vault_output_names" {
  value = { for key, value in azurerm_recovery_services_vault.recovery_services_vault : value.name => value }
}
