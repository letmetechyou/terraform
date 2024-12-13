resource "azurerm_data_protection_backup_vault" "data_protection_backup_vault" {
  for_each = { for key, value in var.data_protection_backup_vault_data : key => value if value.enabled }

  #Required
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  datastore_type      = each.value.datastore_type
  redundancy          = each.value.redundancy

  #Optional
  dynamic "identity" {
    for_each = each.value.identity != null ? [1] : []
    content {
      type = each.value.identity.type
    }
  }
  tags = each.value.tags
}
