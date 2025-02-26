resource "azurerm_monitor_activity_log_alert" "monitor_activity_log_alert" {
  for_each = { for key, value in var.monitor_activity_log_alert_data : key => value if value.enabled }

  # Required Arguments
  scopes              = each.value.scopes
  name                = each.value.name
  resource_group_name = var.resource_group_output["${each.value.resource_group_name}"].name
  location            = each.value.location


  # Required Blocks 

  criteria {
    # Required
    category = each.value.criteria.category

    # Optional
    recommendation_impact   = each.value.criteria.recommendation_impact
    operation_name          = each.value.criteria.operation_name
    recommendation_type     = each.value.criteria.recommendation_type
    caller                  = each.value.criteria.caller
    recommendation_category = each.value.criteria.recommendation_category

    # Optional Mutually Exclusive Values (OR)
    level  = each.value.criteria.levels == null ? each.value.criteria.level : null
    levels = each.value.criteria.level == null ? each.value.criteria.levels : null

    resource_group  = each.value.criteria.resource_groups == null ? each.value.criteria.resource_group : null
    resource_groups = each.value.criteria.resource_group == null ? each.value.criteria.resource_groups : null

    resource_id  = each.value.criteria.resource_ids == null ? each.value.criteria.resource_id : null
    resource_ids = each.value.criteria.resource_id == null ? each.value.criteria.resource_ids : null

    resource_provider  = each.value.criteria.resource_providers == null ? each.value.criteria.resource_provider : null
    resource_providers = each.value.criteria.resource_provider == null ? each.value.criteria.resource_providers : null

    resource_type  = each.value.criteria.resource_types == null ? each.value.criteria.resource_type : null
    resource_types = each.value.criteria.resource_type == null ? each.value.criteria.resource_types : null

    status   = each.value.criteria.statuses == null ? each.value.criteria.status : null
    statuses = each.value.criteria.status == null ? each.value.criteria.statuses : null

    sub_status   = each.value.criteria.sub_statuses == null ? each.value.criteria.sub_status : null
    sub_statuses = each.value.criteria.sub_status == null ? each.value.criteria.sub_statuses : null

    # Optional Blocks
    dynamic "resource_health" {

      for_each = each.value.criteria.resource_health != null ? [1] : []

      content {
        # Required

        # Optional
        previous = each.value.criteria.resource_health.previous
        current  = each.value.criteria.resource_health.current
        reason   = each.value.criteria.resource_health.reason
      }
    }
    #     service_health          = each.value.criteria.service_health
    dynamic "service_health" {

      for_each = each.value.criteria.service_health != null ? [1] : []

      content {
        # Required

        # Optional
        locations = each.value.criteria.service_health.locations
        events    = each.value.criteria.service_health.events
        services  = each.value.criteria.service_health.services
      }
    }
  }


  # Optional Arguments
  tags        = each.value.tags
  description = each.value.description
  enabled     = each.value.enabled


  # Optional Dynamic Blocks
  dynamic "action" {

    for_each = each.value.action != null ? range(length(each.value.action)) : []

    content {
      # Required
      action_group_id = coalesce(
        try(each.value.action[action.key].action_group_id, null),
        try(var.monitor_action_group_output["${each.value.action[action.key].action_group_name}"].id)
      )

      # Optional
      webhook_properties = each.value.action[action.key].webhook_properties
    }
  }

  lifecycle {
    prevent_destroy = false
  }
}
