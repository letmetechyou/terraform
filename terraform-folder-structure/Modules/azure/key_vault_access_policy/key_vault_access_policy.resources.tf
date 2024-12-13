data "azurerm_client_config" "current" {}

resource "azurerm_key_vault_access_policy" "main" {
  for_each = { for key, value in var.key_vault_access_policy_data : key => value if value.enabled }
  key_vault_id = coalesce(
    try(each.value.existing_key_vault_id, null),
    try(var.key_vault_output["${each.value.key_vault_name}"].id, null)
  )
  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = coalesce(try(var.user_assigned_identity_output["${each.value.obj_id}"].principal_id, null),
    try(each.value.obj_id, null)
    #object_id = coalesce(each.value.obj_id, each.value.group_id, each.value.service_principal_id,
    #try(var.user_assigned_identity_output["${each.value.key_vault_access_policy.object_id}"].id,null)
  )
  secret_permissions      = each.value.secret_permissions
  certificate_permissions = each.value.certificate_permissions
  key_permissions         = each.value.key_permissions
  storage_permissions     = each.value.storage_permissions

}