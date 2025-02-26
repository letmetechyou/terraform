output "user_assigned_identity_output" {
  value = zipmap(values(azurerm_user_assigned_identity.main)[*].name, values(azurerm_user_assigned_identity.main)[*])
}

output "user_assigned_identity_output_names" {
  value = { for key, value in azurerm_user_assigned_identity.main : value.name => value }
}