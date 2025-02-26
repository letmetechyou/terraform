output "web_pubsub_network_acl_output" {
  value = zipmap(values(azurerm_web_pubsub_network_acl.web_pubsub_network_acl)[*].name, values(azurerm_web_pubsub_network_acl.web_pubsub_network_acl)[*])
}

output "web_pubsub_network_acl_output_names" {
  value = { for key, value in azurerm_web_pubsub_network_acl.web_pubsub_network_acl : value.name => value }
}
