resource "azurerm_network_watcher_flow_log" "network_watcher_flow_log" {
  for_each = { for key, value in var.network_watcher_flow_log_data : key => value if value.enabled }

  # Required Arguments
  enabled                   = each.value.enabled
  network_watcher_name      = each.value.network_watcher_name
  resource_group_name       = each.value.resource_group_name
  name                      = each.value.name
  network_security_group_id = coalesce(try(each.value.network_security_group_id, null), try(var.network_security_group_output["${each.value.network_security_group_name}"].id, null))
  storage_account_id        = coalesce(try(each.value.storage_account_id, null), try(var.storage_acccount_output["${each.value.storage_account_name}"].id, null))

  # Required Blocks 

  retention_policy {
    # Required
    days    = each.value.retention_policy.days
    enabled = each.value.retention_policy.enabled
  }

  # Optional Arguments
  tags     = each.value.tags
  location = each.value.location
  version  = each.value.version

  # Optional Dynamic Blocks
  dynamic "traffic_analytics" {

    for_each = each.value.traffic_analytics != null ? range(length(each.value.traffic_analytics)) : []

    content {
      # Required
      workspace_resource_id = each.value.traffic_analytics[traffic_analytics.key].workspace_resource_id
      workspace_id          = each.value.traffic_analytics[traffic_analytics.key].workspace_id
      workspace_region      = each.value.traffic_analytics[traffic_analytics.key].workspace_region
      enabled               = each.value.traffic_analytics[traffic_analytics.key].enabled

      # Optional
      interval_in_minutes = each.value.traffic_analytics[traffic_analytics.key].interval_in_minutes
    }
  }

  lifecycle {
    prevent_destroy = false
  }
}
