data "azurerm_client_config" "current" {
}

data "azurerm_key_vault_secret" "main" {
  for_each = { for key, value in var.api_management_data_v2 : key => value if value.enabled }
  name     = each.value.existing_key_vault_certificate_name
  key_vault_id = coalesce(try(each.value.existing_key_vault_id, null),
  try(var.key_vault_output["${each.value.key_vault_name}"].id, null))
}

resource "azurerm_api_management" "main" {
  for_each             = { for key, value in var.api_management_data_v2 : key => value if value.enabled }
  name                 = each.value.name
  location             = each.value.location
  resource_group_name  = var.resource_group_output["${each.value.resource_group_name}"].name
  publisher_name       = each.value.publisher_name
  publisher_email      = each.value.publisher_email
  sku_name             = each.value.sku_name
  public_ip_address_id = try(coalesce(try(var.public_ip_output["${each.value.public_ip_address_name}"].id, null), try(each.value.public_ip_address_id)), null)
  sign_in {
    enabled = each.value.sign_in_enabled
  }
  virtual_network_type = each.value.virtual_network_type
  virtual_network_configuration {
    subnet_id = coalesce(try(each.value.existing_virtual_network_subnet_id, null),
    try(var.subnet_output["${each.value.subnet_name}"].id, null))
  }
  identity {
    type = "SystemAssigned"
  }
  tags = each.value.tags

}

resource "azurerm_key_vault_access_policy" "main" {
  for_each = { for key, value in var.api_management_data_v2 : key => value if value.enabled }
  key_vault_id = coalesce(try(each.value.existing_key_vault_id, null),
  try(var.key_vault_output["${each.value.key_vault_name}"].id, null))
  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = azurerm_api_management.main[each.key].identity[0].principal_id

  key_permissions = [
    "Get",
    "List"
  ]

  secret_permissions = [
    "Get",
    "List"
  ]

  certificate_permissions = [
    "Get",
    "List",
    "GetIssuers",
    "ListIssuers"
  ]
}

resource "azurerm_api_management_custom_domain" "main" {
  for_each          = { for key, value in var.api_management_data_v2 : key => value if value.enabled }
  api_management_id = azurerm_api_management.main[each.key].id

  gateway {
    host_name           = each.value.gateway_hostname
    default_ssl_binding = true
    key_vault_id        = data.azurerm_key_vault_secret.main[each.key].id
  }

  developer_portal {
    host_name    = "${each.value.resource_group_name}-${each.value.env}portal.${each.value.dnsdomain}"
    key_vault_id = data.azurerm_key_vault_secret.main[each.key].id
  }

  management {
    host_name    = "${each.value.resource_group_name}-mgmt.${each.value.dnsdomain}"
    key_vault_id = data.azurerm_key_vault_secret.main[each.key].id
  }

  scm {
    host_name    = "${each.value.resource_group_name}-scm.${each.value.dnsdomain}"
    key_vault_id = data.azurerm_key_vault_secret.main[each.key].id
  }

  portal {
    host_name    = "${each.value.resource_group_name}-portal.${each.value.dnsdomain}"
    key_vault_id = data.azurerm_key_vault_secret.main[each.key].id
  }

  depends_on = [azurerm_key_vault_access_policy.main]
}