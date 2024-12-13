

resource "azurerm_security_center_contact" "main" {
  for_each            = { for key, value in var.security_center_contact_data : key => value if value.enabled }
  name                = each.value.name
  alert_notifications = each.value.alert_notifications
  alerts_to_admins    = each.value.alerts_to_admins
  email               = each.value.email
  phone               = each.value.phone_number
}
