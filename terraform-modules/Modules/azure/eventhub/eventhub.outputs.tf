output "eventhub_output" {
  value = zipmap(values(azurerm_eventhub.eventhub)[*].name, values(azurerm_eventhub.eventhub)[*])
}

output "eventhub_namespace_output" {
  value = zipmap(values(azurerm_eventhub_namespace.namespace)[*].name, values(azurerm_eventhub_namespace.namespace)[*])
}

output "eventhub_output_names" {
  value = { for key, value in azurerm_eventhub.eventhub : value.name => value }
}
