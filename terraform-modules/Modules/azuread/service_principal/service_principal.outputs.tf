output "service_principal_output" {
  value = zipmap(values(azuread_service_principal.service_principal)[*].display_name, values(azuread_service_principal.service_principal)[*])
}

output "service_principal_output_names" {
  value = { for key, value in azuread_service_principal.service_principal : value.display_name => value }
}
