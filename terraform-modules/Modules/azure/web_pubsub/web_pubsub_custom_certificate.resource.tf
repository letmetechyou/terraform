resource "azurerm_web_pubsub_custom_certificate" "web_pubsub_custom_certificate" {
  for_each = { for key, value in var.web_pubsub_custom_certificate_data : key => value if value.enabled }

  # Required Arguments
  custom_certificate_id = each.value.custom_certificate_id
  name                  = each.value.name
  web_pubsub_id         = each.value.web_pubsub_id

  lifecycle {
    prevent_destroy = false
  }
}
