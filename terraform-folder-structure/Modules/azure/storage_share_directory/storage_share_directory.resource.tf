resource "azurerm_storage_share_directory" "storage_share_directory" {
  for_each = { for key, value in var.storage_share_directory_data : key => value if value.enabled }

  # Required Arguments
  name             = each.value.name
  storage_share_id = each.value.storage_share_id


  # Required Blocks 



  # Optional Arguments
  metadata = each.value.metadata


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
