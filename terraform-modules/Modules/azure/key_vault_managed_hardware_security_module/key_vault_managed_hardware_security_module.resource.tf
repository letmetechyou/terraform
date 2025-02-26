data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "main" {
  for_each = { for key, value in var.key_vault_managed_hardware_security_module_data : key => value if value.enabled }
  name     = each.value.existing_resource_group_name
}

resource "azurerm_key_vault_managed_hardware_security_module" "main" {
  for_each = { for key, value in var.key_vault_managed_hardware_security_module_data : key => value if value.enabled }

  name                                      = each.value.key_vault_name
  location                                  = data.azurerm_resource_group.main[each.key].location
  resource_group_name                       = data.azurerm_resource_group.main[each.key].name
  sku_name                                  = "Standard_B1"
  tenant_id                                 = data.azurerm_client_config.current.tenant_id
  admin_object_ids                          = each.value.admin_object_ids
  public_network_access_enabled             = false
  soft_delete_retention_days                = "7"
  security_domain_key_vault_certificate_ids = each.value.security_domain_key_vault_certificate_ids
  security_domain_quorum                    = each.value.security_domain_quorum
  purge_protection_enabled                  = true
  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
  }
  tags = each.value.tags
}