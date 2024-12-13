resource "azurerm_key_vault_managed_hardware_security_module_role_assignment" "main" {
  for_each = { for key, value in var.key_vault_managed_hardware_security_module_role_assignment_data : key => value if value.enabled }

  # Required Arguments
  scope              = each.value.scope
  name               = each.value.name
  principal_id       = each.value.principal_id
  role_definition_id = each.value.role_definition_id
  managed_hsm_id     = each.value.managed_hsm_id


  # Required Blocks 



  # Optional Arguments


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
