resource "azurerm_network_interface" "network_interface" {
  for_each = { for key, value in var.network_interface_data : key => value if value.enabled }

  # Required Arguments
  name = coalesce(
    try(each.value.name, null),
    try(each.key, null)
  )
  location = each.value.location
  resource_group_name = coalesce(
    try(each.value.resource_group_name, null),
    try(var.resource_group_output["${each.value.existing_resource_group_name}"].name, null)
  )


  # Required Blocks 

  dynamic "ip_configuration" {
    for_each = try({ for k, v in each.value.ip_configuration : k => v if v.enabled }, {})
    iterator = ip

    content {
      # Required
      private_ip_address_allocation = ip.value.private_ip_address_allocation
      name = coalesce(
        try(ip.value.name, null),
        try("${each.key}${ip.value.name_suffix}", null)
      )
      # Optional
      private_ip_address_version                         = ip.value.private_ip_address_version
      public_ip_address_id                               = ip.value.public_ip_address_id
      gateway_load_balancer_frontend_ip_configuration_id = ip.value.gateway_load_balancer_frontend_ip_configuration_id
      subnet_id                                          = coalesce(try(ip.value.subnet_id, null), try(var.subnet_output["${ip.value.subnet_name}"].id, null),)
      private_ip_address                                 = ip.value.private_ip_address
      primary                                            = ip.value.primary
    }
  }


  # Optional Arguments
  edge_zone                      = each.value.edge_zone
  auxiliary_mode                 = each.value.auxiliary_mode
  dns_servers                    = each.value.dns_servers
  accelerated_networking_enabled = each.value.accelerated_networking_enabled
  ip_forwarding_enabled          = each.value.ip_forwarding_enabled
  auxiliary_sku                  = each.value.auxiliary_sku
  internal_dns_name_label        = each.value.internal_dns_name_label
  tags                           = each.value.tags


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
