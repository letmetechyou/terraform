data "azurerm_subscription" "current" {}

resource "azurerm_eventhub_namespace_customer_managed_key" "main" {
  for_each                          = { for key, value in var.eventhub_data : key => value if value.namespace != null && value.cmk_enabled }
  eventhub_namespace_id             = azurerm_eventhub_namespace.namespace[each.key].id
  key_vault_key_ids                 = each.value.key_vault_key_ids
  infrastructure_encryption_enabled = true
  user_assigned_identity_id         = each.value.user_assigned_identity_id
  depends_on                        = [azurerm_eventhub_namespace.namespace]
}

resource "azurerm_eventhub_namespace" "namespace" {
  for_each                      = { for key, value in var.eventhub_data : key => value if value.namespace != null }
  name                          = each.value.namespace.name_override != null ? each.value.namespace.name_override : "${lower(replace(replace(data.azurerm_subscription.current.display_name, " ", ""), "-", ""))}-${each.value.environment}-${each.value.location}-evhns"
  resource_group_name           = each.value.resource_group_name
  location                      = each.value.location
  sku                           = each.value.namespace.sku
  capacity                      = each.value.namespace.capacity
  tags                          = each.value.tags
  public_network_access_enabled = coalesce(each.value.namespace.public_network_access_enabled, false) #coalesce returns first non-null/empty value
  local_authentication_enabled  = each.value.namespace.local_authentication_enabled
  dedicated_cluster_id          = each.value.namespace.dedicated_cluster_id
  maximum_throughput_units      = each.value.namespace.maximum_throughput_units

  dynamic "identity" {
    for_each = each.value.identity != null ? [1] : []
    content {
      type         = each.value.identity.type
      identity_ids = each.value.identity.identity_ids
    }
  }

  dynamic "network_rulesets" {
    for_each = each.value.namespace.public_network_access_enabled != true ? [1] : []
    content {
      default_action                 = "Allow"
      public_network_access_enabled  = false
      trusted_service_access_enabled = true
    }
  }
}

resource "azurerm_eventhub" "eventhub" {
  for_each = { for key, value in var.eventhub_data : key => value if value.enabled }

  # Required Arguments
  namespace_name      = coalesce(each.value.existing_namespace_name, azurerm_eventhub_namespace.namespace[each.key].name)
  message_retention   = each.value.message_retention
  resource_group_name = each.value.resource_group_name
  name                = each.value.name_override != null ? each.value.name_override : "${lower(replace(replace(data.azurerm_subscription.current.display_name, " ", ""), "-", ""))}-${each.value.environment}-${each.value.location}-evh"
  partition_count     = each.value.partition_count


  # Required Blocks 



  # Optional Arguments
  status = each.value.status


  # Optional Dynamic Blocks
  dynamic "capture_description" {

    for_each = each.value.capture_description != null ? [1] : []

    content {
      # Required
      destination {
        # Required
        archive_name_format = each.value.capture_description.destination.archive_name_format
        blob_container_name = each.value.capture_description.destination.blob_container_name
        name                = each.value.capture_description.destination.name
        storage_account_id  = each.value.capture_description.destination.storage_account_id
        # Optional
      }
      enabled  = each.value.capture_description[capture_description.key].enabled
      encoding = each.value.capture_description[capture_description.key].encoding

      # Optional
      skip_empty_archives = each.value.capture_description[capture_description.key].skip_empty_archives
      size_limit_in_bytes = each.value.capture_description[capture_description.key].size_limit_in_bytes
      interval_in_seconds = each.value.capture_description[capture_description.key].interval_in_seconds
    }
  }



  lifecycle {
    prevent_destroy = false
  }

  depends_on = [
    azurerm_eventhub_namespace.namespace
  ]
}

resource "azurerm_eventhub_authorization_rule" "authorization_rule" {
  for_each            = { for key, value in var.eventhub_data : key => value if value.authorization_rule != null }
  name                = each.value.authorization_rule.name
  resource_group_name = each.value.resource_group_name
  namespace_name      = azurerm_eventhub_namespace.namespace[each.key].name
  eventhub_name       = azurerm_eventhub.eventhub[each.key].name
  listen              = each.value.authorization_rule.listen
  send                = each.value.authorization_rule.send
  manage              = each.value.authorization_rule.manage

  depends_on = [
    azurerm_eventhub.eventhub
  ]
}

resource "azurerm_eventhub_namespace_authorization_rule" "namespace_authorization_rule" {
  for_each            = { for key, value in var.eventhub_data : key => value if value.namespace.authorization_rule != null }
  name                = each.value.namespace.authorization_rule.name
  resource_group_name = each.value.resource_group_name
  namespace_name      = coalesce(each.value.existing_namespace_name, azurerm_eventhub_namespace.namespace[each.key].name)
  listen              = each.value.namespace.authorization_rule.listen
  send                = each.value.namespace.authorization_rule.send
  manage              = each.value.namespace.authorization_rule.manage

  depends_on = [
    azurerm_eventhub_namespace.namespace
  ]
}

# Private Endpoint (for user access)
resource "azurerm_private_endpoint" "eventhub" {
  for_each            = { for key, value in var.eventhub_data : key => value if value.private_endpoint != null }
  name                = "${azurerm_eventhub_namespace.namespace[each.key].name}-pep"
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  subnet_id           = each.value.private_endpoint.subnet_id
  tags                = each.value.tags

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [each.value.private_endpoint.private_dns_zone_id]
  }

  private_service_connection {
    name                           = "${azurerm_eventhub_namespace.namespace[each.key].name}-psc"
    private_connection_resource_id = azurerm_eventhub_namespace.namespace[each.key].id
    subresource_names              = ["namespace"]
    is_manual_connection           = false
  }
}