output "public_ip_prefix_output" {
  value = zipmap(values(azurerm_public_ip_prefix.public_ip_prefix)[*].name, values(azurerm_public_ip_prefix.public_ip_prefix)[*])
}

output "public_ip_prefix_output_names" {
  value = { for key, value in azurerm_public_ip_prefix.public_ip_prefix : value.name => value }
}
