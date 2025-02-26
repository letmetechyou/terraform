resource "azurerm_express_route_circuit_peering" "express_route_circuit_peering" {
  for_each                      = { for key, value in var.express_route_circuit_peering_data : key => value if value.enabled }
  peering_type                  = each.value.peering_type
  express_route_circuit_name    = each.value.express_route_circuit_name
  resource_group_name           = each.value.resource_group_name
  vlan_id                       = each.value.vlan_id
  primary_peer_address_prefix   = each.value.primary_peer_address_prefix
  secondary_peer_address_prefix = each.value.secondary_peer_address_prefix
  ipv4_enabled                  = each.value.ipv4_enabled
  peer_asn                      = each.value.peer_asn
 dynamic microsoft_peering_config {
       for_each = each.value.microsoft_peering_config != null ? [1] : []
  content {
     advertised_public_prefixes = each.value.microsoft_peering_config.advertised_public_prefixes
     customer_asn = each.value.microsoft_peering_config.customer_asn
     routing_registry_name = each.value.microsoft_peering_config.routing_registry_name
     advertised_communities = each.value.microsoft_peering_config.advertised_communities
  }


  }
}