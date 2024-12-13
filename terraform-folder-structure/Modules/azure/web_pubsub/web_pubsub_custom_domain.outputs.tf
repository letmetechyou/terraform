output "web_pubsub_custom_domain_output" {
  value = zipmap(values(azurerm_web_pubsub_custom_domain.web_pubsub_custom_domain)[*].name, values(azurerm_web_pubsub_custom_domain.web_pubsub_custom_domain)[*])
}

output "web_pubsub_custom_domain_output_names" {
  value = { for key, value in azurerm_web_pubsub_custom_domain.web_pubsub_custom_domain : value.name => value }
}
