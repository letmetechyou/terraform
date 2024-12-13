resource "azurerm_web_pubsub_network_acl" "web_pubsub_network_acl" {
  for_each = { for key, value in var.web_pubsub_network_acl_data : key => value if value.enabled }

  # Required Arguments
  web_pubsub_id  = each.value.web_pubsub_id
  default_action = each.value.action
  id             = each.value.id


  # Required Blocks 

  public_network {
    # Required
    # Optional
    allowed_request_types = each.value.public_network.allowed_request_types
    denied_request_types  = each.value.public_network.denied_request_types
  }

  # Optional Dynamic Blocks
  dynamic "private_endpoint" {

    for_each = each.value.private_endpoint != null ? range(length(each.value.private_endpoint)) : []

    content {
      # Required
      id = each.value.private_endpoint[private_endpoint.key].id

      # Optional
      denied_request_types  = each.value.private_endpoint[private_endpoint.key].denied_request_types
      allowed_request_types = each.value.private_endpoint[private_endpoint.key].allowed_request_types
    }
  }



  lifecycle {
    prevent_destroy = false
  }
}
