output "subnet_output" {
  value = zipmap(keys(azurerm_subnet.subnet), values(azurerm_subnet.subnet)[*])
}

output "subnet_output_names" {
  value = { for key, value in azurerm_subnet.subnet : "${value.virtual_network_name}_${value.name}" => value }
}
