output "web_pubsub_custom_certificate_output" {
  value = zipmap(values(azurerm_web_pubsub_custom_certificate.web_pubsub_custom_certificate)[*].name, values(azurerm_web_pubsub_custom_certificate.web_pubsub_custom_certificate)[*])
}

output "web_pubsub_custom_certificate_output_names" {
  value = { for key, value in azurerm_web_pubsub_custom_certificate.web_pubsub_custom_certificate : value.name => value }
}
