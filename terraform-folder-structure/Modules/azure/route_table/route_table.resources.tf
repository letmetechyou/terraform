

resource "azurerm_route_table" "main" {
  for_each = { for key, value in var.route_table_data : key => value if value.enabled }

  name     = each.value.name
  location = each.value.location
  resource_group_name = coalesce(
    try(var.resource_group_output["${each.value.resource_group_name}"].name, null),
    try(var.resource_group_output["${each.value.existing_resource_group_name}"].name, null)
  )
  bgp_route_propagation_enabled = each.value.bgp_route_propagation_enabled

  dynamic "route" {
    for_each = each.value.routes != null ? range(length(each.value.routes)) : []
    content {
      name                   = each.value.routes[route.key].name
      address_prefix         = each.value.routes[route.key].address_prefix
      next_hop_type          = each.value.routes[route.key].next_hop_type
      next_hop_in_ip_address = each.value.routes[route.key].next_hop_in_ip_address
    }

  }

  tags = each.value.tags
}
