output "express_route_circuit_output" {
  value = zipmap(values(azurerm_express_route_circuit.express_route_circuit)[*].name, values(azurerm_express_route_circuit.express_route_circuit)[*])
}

output "express_route_circuit_output_names" {
  value = { for key, value in azurerm_express_route_circuit.express_route_circuit : value.name => value }
}
