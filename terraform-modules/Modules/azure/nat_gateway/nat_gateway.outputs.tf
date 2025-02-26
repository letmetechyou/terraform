output "nat_gateway_output" {
  value = zipmap(values(azurerm_nat_gateway.nat_gateway)[*].name, values(azurerm_nat_gateway.nat_gateway)[*])
}

output "nat_gateway_output_names" {
  value = { for key, value in azurerm_nat_gateway.nat_gateway : value.name => value }
}
