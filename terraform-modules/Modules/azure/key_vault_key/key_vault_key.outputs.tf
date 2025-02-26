output "key_vault_key_output" {
  value = zipmap(values(azurerm_key_vault_key.key_vault_key)[*].name, values(azurerm_key_vault_key.key_vault_key)[*])
}

output "key_vault_key_output_names" {
  value = { for key, value in azurerm_key_vault_key.key_vault_key : value.name => value }
}
