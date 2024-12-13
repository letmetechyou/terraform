resource "azurerm_key_vault_secret" "key_vault_secret" {
  for_each = { for key, value in var.key_vault_secret_data : key => value if value.enabled }

  # Required Arguments
  name = coalesce(
    try(each.value.name, null),
    try(each.key, null)
  )
  value = coalesce(
    try(each.value.value, null),
    try(var.tls_private_key_output["${each.value.tls_private_key_name}"].private_key_openssh, null),
    try(var.tls_private_key_output["${each.key}"].private_key_openssh, null)
  )
  key_vault_id = coalesce(
    try(each.value.key_vault_id, null),
    try(var.key_vault_output["${each.value.key_vault_name}"].id, null),
    try(each.value.existing_key_vault.key_vault_id, null),
    try(var.key_vault_output["${each.value.existing_key_vault.key_vault_name}"].id, null)
  )

  # Required Blocks 



  # Optional Arguments
  tags            = each.value.tags
  content_type    = each.value.content_type
  not_before_date = each.value.not_before_date
  expiration_date = each.value.expiration_date


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
