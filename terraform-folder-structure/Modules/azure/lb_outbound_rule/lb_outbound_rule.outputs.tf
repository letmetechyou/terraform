output "lb_outbound_rule_output" {
  value = zipmap(values(azurerm_lb_outbound_rule.lb_outbound_rule)[*].name, values(azurerm_lb_outbound_rule.lb_outbound_rule)[*])
}

output "lb_outbound_rule_output_names" {
  value = { for key, value in azurerm_lb_outbound_rule.lb_outbound_rule : value.name => value }
}
