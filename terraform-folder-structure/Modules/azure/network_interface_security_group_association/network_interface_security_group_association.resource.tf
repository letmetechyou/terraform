resource "azurerm_network_interface_security_group_association" "network_interface_security_group_association" {
  for_each = { for key, value in var.network_interface_security_group_association_data : key => value if value.enabled }

  # Required Arguments
  network_interface_id = coalesce(
    try(each.value.network_interface_id, null),
    try(var.network_interface_output["${each.value.network_interface_name}"].id, null),
    try(var.network_interface_output["${each.key}"].id, null)
  )
  network_security_group_id = coalesce(
    try(each.value.network_security_group_id, null),
    try(var.network_security_group_output["${each.value.network_security_group_name}"].id, null)
  )


  # Required Blocks 



  # Optional Arguments


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
