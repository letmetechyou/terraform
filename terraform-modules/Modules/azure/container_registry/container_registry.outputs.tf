output "container_registry_output" {
  value = zipmap(values(azurerm_container_registry.main)[*].name, values(azurerm_container_registry.main)[*])
}

output "container_registry_output_names" {
  value = { for key, value in azurerm_container_registry.main : value.name => value }
}
