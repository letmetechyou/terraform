resource "azurerm_network_security_rule" "network_security_rule" {
  for_each = { for key, value in var.network_security_rule_data : key => value if value.enabled }

  # Required Arguments
  protocol                    = each.value.protocol
  priority                    = each.value.priority
  access                      = each.value.access
  name                        = each.value.name
  network_security_group_name = var.network_security_group_output["${each.value.network_security_group_name}"].name
  resource_group_name         = each.value.resource_group_name
  direction                   = each.value.direction


  # Required Blocks 



  # Optional Arguments
  description                                = each.value.description
  source_application_security_group_ids      = each.value.source_application_security_group_ids
  destination_application_security_group_ids = each.value.destination_application_security_group_ids

  source_port_range  = each.value.source_port_ranges == null ? each.value.source_port_range : null
  source_port_ranges = each.value.source_port_range == null ? each.value.source_port_ranges : null

  destination_port_range  = each.value.destination_port_ranges == null ? each.value.destination_port_range : null
  destination_port_ranges = each.value.destination_port_range == null ? each.value.destination_port_ranges : null

  source_address_prefix   = each.value.source_address_prefixes == null ? each.value.source_address_prefix : null
  source_address_prefixes = each.value.source_address_prefix == null ? each.value.source_address_prefixes : null

  destination_address_prefix   = each.value.destination_address_prefixes == null ? each.value.destination_address_prefix : null
  destination_address_prefixes = each.value.destination_address_prefix == null ? each.value.destination_address_prefixes : null

  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
