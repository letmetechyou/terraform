resource "azurerm_application_insights" "application_insights" {
  for_each = { for key, value in var.application_insights_data : key => value if value.enabled }

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  application_type    = each.value.application_type
  retention_in_days   = each.value.retention_in_days
  disable_ip_masking  = each.value.disable_ip_masking
  workspace_id        = each.value.workspace_id
}