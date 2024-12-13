output "nat_gateway_public_ip_association_output" {
  value = values(azurerm_nat_gateway_public_ip_association.nat_gateway_public_ip_association)[*]
}
