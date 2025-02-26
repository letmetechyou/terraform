output "subnet_nat_gateway_association_output" {
  value = values(azurerm_subnet_nat_gateway_association.subnet_nat_gateway_association)[*]
}
