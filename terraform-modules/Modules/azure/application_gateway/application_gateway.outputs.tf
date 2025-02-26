output "application_gateway_output" {
  value = zipmap(values(azurerm_application_gateway.application_gateway)[*].name, values(azurerm_application_gateway.application_gateway)[*])
}

output "application_gateway_output_names" {
  value = { for key, value in azurerm_application_gateway.application_gateway : value.name => value }
}
