resource "azurerm_express_route_circuit" "express_route_circuit" {
  for_each = { for key, value in var.express_route_circuit_data : key => value if value.enabled }

  # Required Arguments
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  tags                = each.value.tags

  # Required Blocks 
  sku {
    tier   = each.value.sku.tier
    family = each.value.sku.family
  }


  # Optional Arguments
  service_provider_name    = each.value.service_provider_name
  peering_location         = each.value.peering_location
  bandwidth_in_mbps        = each.value.bandwidth_in_mbps
  allow_classic_operations = each.value.allow_classic_operations
  express_route_port_id    = each.value.express_route_port_id
  bandwidth_in_gbps        = each.value.bandwidth_in_gbps
  authorization_key        = each.value.authorization_key

  # Optional Dynamic Blocks
}
