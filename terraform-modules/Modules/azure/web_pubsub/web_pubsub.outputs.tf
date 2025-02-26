output "web_pubsub_output" {
  value = zipmap(values(azurerm_web_pubsub.web_pubsub)[*].name, values(azurerm_web_pubsub.web_pubsub)[*])
}

output "web_pubsub_output_names" {
  value = { for key, value in azurerm_web_pubsub.web_pubsub : value.name => value }
}
