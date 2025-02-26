output "user_output" {
  value = zipmap(values(azuread_user.user)[*].display_name, values(azuread_user.user)[*])
}

output "user_output_names" {
  value = { for key, value in azuread_user.user : value.display_name => value }
}
