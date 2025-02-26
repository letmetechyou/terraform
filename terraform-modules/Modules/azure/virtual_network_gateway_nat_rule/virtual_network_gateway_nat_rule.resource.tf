resource "azurerm_virtual_network_gateway_nat_rule" "virtual_network_gateway_nat_rule" {
  for_each = { for key, value in var.virtual_network_gateway_nat_rule_data : key => value if value.enabled }

  # Required Arguments
  virtual_network_gateway_id = each.value.virtual_network_gateway_id
  name                       = each.value.name
  resource_group_name        = each.value.resource_group_name


  # Required Blocks 

  external_mapping {
    # Required

    address_space = each.value.external_mapping.address_space

    # Optional

    port_range = each.value.external_mapping.port_range
  }

  internal_mapping {
    # Required

    address_space = each.value.internal_mapping.address_space

    # Optional

    port_range = each.value.internal_mapping.port_range
  }


  # Optional Arguments

  type                = each.value.type
  ip_configuration_id = each.value.ip_configuration_id
  mode                = each.value.mode


  lifecycle {
    prevent_destroy = false
  }
}
