data "azurerm_client_config" "current" {}

# data "azurerm_resource_group" "main" {
#   for_each = { for key, value in var.key_vault_data : key => value if value.enabled }
#   name     = each.value.existing_resource_group_name
# }


resource "azurerm_key_vault" "main" {
  for_each = { for key, value in var.key_vault_data : key => value if value.enabled }
  name     = each.value.key_vault_name
  location = each.value.location
  resource_group_name = coalesce(
    try(each.value.existing_resource_group_name, null),
    try(var.resource_group_output["${each.value.existing_resource_group_name}"].name, null)
  )
  sku_name                        = "premium"
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  public_network_access_enabled   = each.value.public_network_access_enabled
  soft_delete_retention_days      = "7"
  enabled_for_deployment          = true
  enabled_for_disk_encryption     = true
  enabled_for_template_deployment = true
  purge_protection_enabled        = each.value.purge_protection_enabled
  network_acls {
    default_action             = "Deny"
    ip_rules                   = each.value.allowed_ip_rules
    virtual_network_subnet_ids = each.value.allowed_subnet_ids
    bypass                     = "AzureServices"
  }
  tags = each.value.tags
  lifecycle {
  }
}
