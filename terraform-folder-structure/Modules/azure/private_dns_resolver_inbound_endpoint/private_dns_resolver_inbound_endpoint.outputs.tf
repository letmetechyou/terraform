output "private_dns_resolver_inbound_endpoint_output" {
  value = zipmap(values(azurerm_private_dns_resolver_inbound_endpoint.private_dns_resolver_inbound_endpoint)[*].name, values(azurerm_private_dns_resolver_inbound_endpoint.private_dns_resolver_inbound_endpoint)[*])
}

output "private_dns_resolver_inbound_endpoint_output_names" {
  value = { for key, value in azurerm_private_dns_resolver_inbound_endpoint.private_dns_resolver_inbound_endpoint : value.name => value }
}
