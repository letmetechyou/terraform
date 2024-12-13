resource "azurerm_local_network_gateway" "local_network_gateway" {
  for_each = { for key, value in var.local_network_gateway_data : key => value if value.enabled }

  # Required Arguments
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  # Optional Arguments
  address_space = each.value.address_space
  tags          = each.value.tags

  # Optional Mutually Exclusive Values (OR)
  gateway_fqdn    = each.value.gateway_address == null ? each.value.gateway_fqdn : null
  gateway_address = each.value.gateway_fqdn == null ? each.value.gateway_address : null

  # Optional Dynamic Blocks
  dynamic "bgp_settings" {

    for_each = each.value.bgp_settings != null ? range(length(each.value.bgp_settings)) : []

    content {
      # Required
      bgp_peering_address = each.value.bgp_settings[bgp_settings.key].bgp_peering_address
      asn                 = each.value.bgp_settings[bgp_settings.key].asn

      # Optional
      peer_weight = each.value.bgp_settings[bgp_settings.key].peer_weight
    }
  }



  lifecycle {
    prevent_destroy = false
  }
}
