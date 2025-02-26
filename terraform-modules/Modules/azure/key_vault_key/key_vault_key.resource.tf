resource "azurerm_key_vault_key" "key_vault_key" {
  for_each = { for key, value in var.key_vault_key_data : key => value if value.enabled }

  # Required Arguments
  name         = each.value.name
  key_type     = each.value.key_type
  key_vault_id = coalesce(try(each.value.key_vault_id, null), try(var.key_vault_output["${each.value.key_vault_name}"].id, null))
  key_opts     = each.value.key_opts


  # Optional Arguments
  tags            = each.value.tags
  key_size        = each.value.key_size
  curve           = each.value.curve
  not_before_date = each.value.not_before_date
  expiration_date = each.value.expiration_date


  # Optional Dynamic Blocks
  dynamic "rotation_policy" {
    for_each = each.value.rotation_policy != null ? [1] : []
    content {
      expire_after         = each.value.expire_after
      notify_before_expiry = each.value.notify_before_expiry
      dynamic "automatic" {
        for_each = each.value.rotation_policy.automatic != null ? [1] : []
        content {
          time_after_creation = each.value.time_after_creation
          time_before_expiry  = each.value.time_before_expiry
        }
      }
    }
  }


  lifecycle {
    prevent_destroy = false
  }
}