resource "azurerm_recovery_services_vault" "recovery_services_vault" {
  for_each = { for key, value in var.recovery_services_vault_data : key => value if value.enabled }

  # Required Arguments
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  sku                 = each.value.sku

  # Optional Arguments
  tags                               = each.value.tags
  public_network_access_enabled      = each.value.public_network_access_enabled
  immutability                       = each.value.immutability
  storage_mode_type                  = each.value.storage_mode_type
  cross_region_restore_enabled       = each.value.cross_region_restore_enabled
  soft_delete_enabled                = each.value.soft_delete_enabled
  classic_vmware_replication_enabled = each.value.classic_vmware_replication_enabled

  # Optional Dynamic Blocks
  dynamic "monitoring" {
    for_each = each.value.monitoring != null ? [1] : []
    content {
      alerts_for_all_job_failures_enabled            = each.value.alerts_for_all_job_failures_enabled
      alerts_for_critical_operation_failures_enabled = each.value.alerts_for_critical_operation_failures_enabled
    }
  }

  dynamic "encryption" {
    for_each = each.value.encryption != null ? [1] : []
    content {
      key_id                            = each.value.encryption.key_id
      infrastructure_encryption_enabled = each.value.encryption.infrastructure_encryption_enabled
      user_assigned_identity_id         = each.value.encryption.user_assigned_identity_id
      use_system_assigned_identity      = each.value.encryption.use_system_assigned_identity
    }
  }

  dynamic "identity" {
    for_each = each.value.identity != null ? [1] : []
    content {
      type         = each.value.identity.type
      identity_ids = each.value.identity.identity_ids
    }
  }

  lifecycle {
    prevent_destroy = false
  }
}
