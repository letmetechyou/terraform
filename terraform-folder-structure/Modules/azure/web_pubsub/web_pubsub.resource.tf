resource "azurerm_web_pubsub" "web_pubsub" {
  for_each = { for key, value in var.web_pubsub_data : key => value if value.enabled }

  # Required Arguments
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  sku                 = each.value.sku


  # Required Blocks 



  # Optional Arguments
  capacity                      = each.value.capacity
  public_network_access_enabled = each.value.public_network_access_enabled
  tls_client_cert_enabled       = each.value.tls_client_cert_enabled
  tags                          = each.value.tags
  local_auth_enabled            = each.value.local_auth_enabled
  aad_auth_enabled              = each.value.aad_auth_enabled


  # Optional Dynamic Blocks
  dynamic "live_trace" {

    for_each = each.value.live_trace != null ? range(length(each.value.live_trace)) : []

    content {
      # Required

      # Optional
      messaging_logs_enabled    = each.value.live_trace[live_trace.key].messaging_logs_enabled
      http_request_logs_enabled = each.value.live_trace[live_trace.key].http_request_logs_enabled
      connectivity_logs_enabled = each.value.live_trace[live_trace.key].connectivity_logs_enabled
      enabled                   = each.value.live_trace[live_trace.key].enabled
    }
  }

  dynamic "identity" {

    for_each = each.value.identity != null ? range(length(each.value.identity)) : []

    content {
      # Required
      type = each.value.identity[identity.key].type
      # Optional
      identity_ids = each.value.identity[identity.key].identity_ids
    }
  }



  lifecycle {
    prevent_destroy = false
  }
}
