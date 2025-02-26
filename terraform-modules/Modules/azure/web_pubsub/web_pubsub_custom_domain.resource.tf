resource "azurerm_web_pubsub_custom_domain" "web_pubsub_custom_domain" {
  for_each = { for key, value in var.web_pubsub_custom_domain_data : key => value if value.enabled }

  # Required Arguments
  web_pubsub_custom_certificate_id = each.value.web_pubsub_custom_certificate_id
  domain_name                      = each.value.domain_name
  name                             = each.value.name
  web_pubsub_id                    = each.value.web_pubsub_id

  lifecycle {
    prevent_destroy = false
  }
}
