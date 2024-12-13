output "network_security_rule_output" {
  value = zipmap(values(azurerm_network_security_rule.network_security_rule)[*].name, values(azurerm_network_security_rule.network_security_rule)[*])
}

/*
output "network_security_rule_output_names" {
  value = { for key, value in azurerm_network_security_rule.network_security_rule : value.name => value }
}
*/