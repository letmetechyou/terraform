output "local_network_gateway_output" {
  value = zipmap(values(azurerm_local_network_gateway.local_network_gateway)[*].name, values(azurerm_local_network_gateway.local_network_gateway)[*])
}

output "local_network_gateway_output_names" {
  value = { for key, value in azurerm_local_network_gateway.local_network_gateway : value.name => value }
}
