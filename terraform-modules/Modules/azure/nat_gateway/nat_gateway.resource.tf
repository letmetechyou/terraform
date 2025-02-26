resource "azurerm_nat_gateway" "nat_gateway" {
  for_each = { for key, value in var.nat_gateway_data : key => value if value.enabled }

  # Required Arguments
  location            = each.value.location
  name                = each.value.name
  resource_group_name = each.value.resource_group_name


  # Required Blocks 



  # Optional Arguments
  sku_name                = each.value.sku_name
  zones                   = each.value.zones
  tags                    = each.value.tags
  idle_timeout_in_minutes = each.value.idle_timeout_in_minutes


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
