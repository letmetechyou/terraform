resource "azurerm_cdn_frontdoor_firewall_policy" "main" {
  for_each                          = try({ for key, value in var.cdn_frontdoor_firewall_policies_data : key => value }, {})
  name                              = each.value.name
  resource_group_name               = each.value.resource_group_name
  sku_name                          = each.value.sku_name
  enabled                           = each.value.enabled
  mode                              = each.value.mode
  redirect_url                      = each.value.redirect_url
  custom_block_response_status_code = each.value.custom_block_response_status_code
  custom_block_response_body        = each.value.custom_block_response_body

  dynamic "custom_rule" {
    for_each = each.value.custom_rules
    content {
      name                           = custom_rule.value.name
      enabled                        = custom_rule.value.enabled
      priority                       = custom_rule.value.priority
      rate_limit_duration_in_minutes = custom_rule.value.rate_limit_duration_in_minutes
      rate_limit_threshold           = custom_rule.value.rate_limit_threshold
      type                           = custom_rule.value.type
      action                         = custom_rule.value.action

      dynamic "match_condition" {
        for_each = custom_rule.value.match_conditions
        content {
          match_variable     = match_condition.value.match_variable
          match_values       = match_condition.value.match_values
          operator           = match_condition.value.operator
          selector           = match_condition.value.selector
          negation_condition = match_condition.value.negate_condition
          transforms         = match_condition.value.transforms
        }
      }
    }
  }

  dynamic "managed_rule" {
    for_each = each.value.managed_rules
    content {
      type    = managed_rule.value.type
      version = managed_rule.value.version
      action  = managed_rule.value.action
      dynamic "exclusion" {
        for_each = managed_rule.value.exclusions
        content {
          match_variable = exclusion.value.match_variable
          operator       = exclusion.value.operator
          selector       = exclusion.value.selector
        }
      }
      dynamic "override" {
        for_each = managed_rule.value.overrides
        content {
          rule_group_name = override.value.rule_group_name
          dynamic "exclusion" {
            for_each = override.value.exclusions
            content {
              match_variable = exclusion.value.match_variable
              operator       = exclusion.value.operator
              selector       = exclusion.value.selector
            }
          }
          dynamic "rule" {
            for_each = override.value.rules
            content {
              rule_id = rule.value.rule_id
              action  = rule.value.action
              enabled = rule.value.enabled
              dynamic "exclusion" {
                for_each = rule.value.exclusions
                content {
                  match_variable = exclusion.value.match_variable
                  operator       = exclusion.value.operator
                  selector       = exclusion.value.selector
                }
              }
            }
          }
        }
      }
    }
  }

  tags = each.value.tags
}

resource "azurerm_cdn_frontdoor_security_policy" "main" {
  for_each                 = try({ for key, value in var.cdn_frontdoor_security_policies_data : key => value }, {})
  name                     = each.value.name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.main[each.value.cdn_frontdoor_profile_name].id

  security_policies {
    firewall {
      cdn_frontdoor_firewall_policy_id = azurerm_cdn_frontdoor_firewall_policy.main[each.value.firewall_policy_name].id
      association {
        patterns_to_match = each.value.patterns_to_match
        dynamic "domain" {
          for_each = each.value.custom_domain_names
          content {
            cdn_frontdoor_domain_id = azurerm_cdn_frontdoor_custom_domain.main[domain.value].id
          }
        }
        dynamic "domain" {
          for_each = each.value.endpoint_names
          content {
            cdn_frontdoor_domain_id = azurerm_cdn_frontdoor_endpoint.main[domain.value].id
          }
        }
      }
    }
  }
}