resource "azurerm_user_assigned_identity" "main" {
  for_each            = { for key, value in var.user_assigned_identity_data : key => value if value.enabled }
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  tags = each.value.tags
}