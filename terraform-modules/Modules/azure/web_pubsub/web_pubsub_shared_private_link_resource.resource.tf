data "azurerm_web_pubsub_private_link_resource" "main" {
  for_each      = { for key, value in var.web_pubsub_shared_private_link_resource_data : key => value if value.enabled }
  web_pubsub_id = each.value.web_pubsub_id
}

resource "azurerm_web_pubsub_shared_private_link_resource" "web_pubsub_shared_private_link_resource" {
  for_each = { for key, value in var.web_pubsub_shared_private_link_resource_data : key => value if value.enabled }

  # Required Arguments
  name               = each.value.name
  web_pubsub_id      = each.value.web_pubsub_id
  subresource_name   = each.value
  target_resource_id = each.value.target_resource_id

  lifecycle {
    prevent_destroy = false
  }
}
