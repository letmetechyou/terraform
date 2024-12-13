resource "azurerm_availability_set" "availability_set" {
  for_each = { for key, value in var.availability_set_data : key => value if value.enabled }

  # Required Arguments
  resource_group_name = coalesce(
    try(each.value.resource_group_name, null),
    try(var.resource_group_output["${each.value.existing_resource_group_name}"].name, null)
  )
  name = coalesce(
    try(each.value.name, null),
    try(each.key, null)
  )
  location = each.value.location


  # Required Blocks 



  # Optional Arguments
  managed                      = each.value.managed
  tags                         = each.value.tags
  platform_update_domain_count = each.value.platform_update_domain_count
  platform_fault_domain_count  = each.value.platform_fault_domain_count
  proximity_placement_group_id = each.value.proximity_placement_group_id


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
