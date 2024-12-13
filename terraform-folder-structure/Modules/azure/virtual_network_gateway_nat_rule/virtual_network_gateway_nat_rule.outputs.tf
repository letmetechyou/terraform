output "virtual_network_gateway_nat_rule_output" {
  value = zipmap(values(azurerm_virtual_network_gateway_nat_rule.virtual_network_gateway_nat_rule)[*].name, values(azurerm_virtual_network_gateway_nat_rule.virtual_network_gateway_nat_rule)[*])
}

output "virtual_network_gateway_nat_rule_output_names" {
  value = { for key, value in azurerm_virtual_network_gateway_nat_rule.virtual_network_gateway_nat_rule : value.name => value }
}
