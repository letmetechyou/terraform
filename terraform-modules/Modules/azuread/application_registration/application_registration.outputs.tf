output "application_registration_output" {
  value = zipmap(values(azuread_application_registration.application_registration)[*].display_name, values(azuread_application_registration.application_registration)[*])
}

output "application_registration_output_names" {
  value = { for key, value in azuread_application_registration.application_registration : value.display_name => value }
}
