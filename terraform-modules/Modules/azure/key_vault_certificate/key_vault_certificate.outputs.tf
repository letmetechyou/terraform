output "key_vault_certificate_output" {
  value = zipmap(values(azurerm_key_vault_certificate.key_vault_certificate)[*].name, values(azurerm_key_vault_certificate.key_vault_certificate)[*])
}

output "key_vault_certificate_output_names" {
  value = { for key, value in azurerm_key_vault_certificate.key_vault_certificate : value.name => value }
}
