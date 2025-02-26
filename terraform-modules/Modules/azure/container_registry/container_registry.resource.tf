resource "azurerm_container_registry" "main" {
  for_each = { for key, value in var.container_registry_data : key => value if value.enabled }

  # Required Arguements
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  sku                 = each.value.sku

  # Required Blocks 


  # Optional Arguments
  admin_enabled                 = each.value.admin_enabled
  public_network_access_enabled = each.value.public_network_access_enabled
  tags                          = each.value.tags


  # Optional Premium SKU only
  export_policy_enabled      = each.value.export_policy_enabled
  zone_redundancy_enabled    = each.value.zone_redundancy_enabled
  quarantine_policy_enabled  = each.value.quarantine_policy_enabled
  anonymous_pull_enabled     = each.value.anonymous_pull_enabled
  data_endpoint_enabled      = each.value.data_endpoint_enabled
  network_rule_bypass_option = each.value.network_rule_bypass_option
  retention_policy_in_days   = each.value.retention_policy_days
  trust_policy_enabled       = each.value.trust_policy_enabled

  # Optional Dynamic Blocks
  dynamic "network_rule_set" {
    for_each = each.value.network_rule_set != null ? [1] : []

    content {
      #Required

      #Optional
      default_action = each.value.network_rule_set.default_action

      # Optional Dynamic Blocks
      dynamic "ip_rule" {
        # for_each = try(network_rule_set.value.ip_rules, {})
        for_each = each.value.network_rule_set.ip_rule != null ? range(length(each.value.network_rule_set.ip_rule)) : []

        content {
          #Required
            action   = each.value.network_rule_set.ip_rule[ip_rule.key].action
            ip_range = each.value.network_rule_set.ip_rule[ip_rule.key].ip_range 

          #Optional
        }
      }
    }
  }

  dynamic "identity" {
    for_each = each.value.identity != null ? [1] : []

    content {
      #Required
      type = each.value.identity.type
      #Optional
      identity_ids = each.value.identity.identity_ids
    }
  }

  dynamic "georeplications" {
    for_each = each.value.georeplications != null ? range(length(each.value.georeplications)) : []

    content {
      location                  = each.value.georeplications[georeplications.key].location
      regional_endpoint_enabled = each.value.georeplications[georeplications.key].regional_endpoint_enabled
      zone_redundancy_enabled   = each.value.georeplications[georeplications.key].zone_redundancy_enabled
      tags                      = each.value.georeplications[georeplications.key].tags
    }
  }

  dynamic "encryption" {
    for_each = each.value.encryption != null ? [1] : []

    content {
      #Required
      key_vault_key_id   = each.value.encryption.key_vault_key_id
      identity_client_id = each.value.encryption.identity_client_id

      #Optional
    }
  }

}