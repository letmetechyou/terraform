resource "azurerm_public_ip_prefix" "public_ip_prefix" {
  for_each = { for key, value in var.public_ip_prefix_data : key => value if value.enabled }

  # Required Arguments
  location            = each.value.location
  name                = each.value.name
  resource_group_name = each.value.resource_group_name


  # Required Blocks 



  # Optional Arguments
  tags          = each.value.tags
  zones         = each.value.zones
  sku           = each.value.sku
  ip_version    = each.value.ip_version
  prefix_length = each.value.prefix_length


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
