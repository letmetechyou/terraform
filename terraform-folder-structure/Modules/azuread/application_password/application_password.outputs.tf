output "application_password_output" {
  value = zipmap(values(azuread_application_password.application_password)[*].display_name, values(azuread_application_password.application_password)[*])
}

output "application_password_output_names" {
  value = { for key, value in azuread_application_password.application_password : value.display_name => value }
}
