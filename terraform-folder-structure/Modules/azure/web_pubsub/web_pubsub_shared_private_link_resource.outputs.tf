output "web_pubsub_shared_private_link_resource_output" {
  value = zipmap(values(azurerm_web_pubsub_shared_private_link_resource.web_pubsub_shared_private_link_resource)[*].name, values(azurerm_web_pubsub_shared_private_link_resource.web_pubsub_shared_private_link_resource)[*])
}

output "web_pubsub_shared_private_link_resource_output_names" {
  value = { for key, value in azurerm_web_pubsub_shared_private_link_resource.web_pubsub_shared_private_link_resource : value.name => value }
}
