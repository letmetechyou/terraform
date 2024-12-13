resource "azurerm_nat_gateway_public_ip_prefix_association" "nat_gateway_public_ip_prefix_association" {
  for_each = { for key, value in var.nat_gateway_public_ip_prefix_association_data : key => value if value.enabled }

  # Required Arguments
  public_ip_prefix_id = coalesce(
    try(each.value.public_ip_prefix_id, null),
    try(var.public_ip_prefix_output["${each.value.public_ip_prefix_name}"].id, null)
  )
  nat_gateway_id = coalesce(
    try(each.value.nat_gateway_id, null),
    try(var.nat_gateway_output["${each.value.nat_gateway_name}"].id, null)
  )


  # Required Blocks 



  # Optional Arguments


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
