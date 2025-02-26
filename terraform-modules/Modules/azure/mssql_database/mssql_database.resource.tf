resource "azurerm_mssql_database" "mssql_database" {
  for_each = { for key, value in var.mssql_database_data : key => value if value.enabled }

  # Required Arguments
  name      = each.value.name
  server_id = each.value.server_id


  # Required Blocks 



  # Optional Arguments
  sku_name                                                   = each.value.sku_name
  creation_source_database_id                                = each.value.creation_source_database_id
  sample_name                                                = each.value.sample_name
  geo_backup_enabled                                         = each.value.geo_backup_enabled
  maintenance_configuration_name                             = each.value.maintenance_configuration_name
  max_size_gb                                                = each.value.max_size_gb
  ledger_enabled                                             = each.value.ledger_enabled
  read_scale                                                 = each.value.read_scale
  storage_account_type                                       = each.value.storage_account_type
  restore_point_in_time                                      = each.value.restore_point_in_time
  auto_pause_delay_in_minutes                                = each.value.auto_pause_delay_in_minutes
  collation                                                  = each.value.collation
  recover_database_id                                        = each.value.recover_database_id
  min_capacity                                               = each.value.min_capacity
  transparent_data_encryption_key_automatic_rotation_enabled = each.value.transparent_data_encryption_key_automatic_rotation_enabled
  license_type                                               = each.value.license_type
  zone_redundant                                             = each.value.zone_redundant
  elastic_pool_id                                            = each.value.elastic_pool_id
  tags                                                       = each.value.tags
  restore_dropped_database_id                                = each.value.restore_dropped_database_id
  enclave_type                                               = each.value.enclave_type
  read_replica_count                                         = each.value.read_replica_count
  transparent_data_encryption_enabled                        = each.value.transparent_data_encryption_enabled
  transparent_data_encryption_key_vault_key_id               = each.value.transparent_data_encryption_key_vault_key_id
  create_mode                                                = each.value.create_mode


  # Optional Dynamic Blocks
  dynamic "short_term_retention_policy" {

    for_each = each.value.short_term_retention_policy != null ? range(length(each.value.short_term_retention_policy)) : []

    content {
      # Required
      retention_days = each.value.short_term_retention_policy[short_term_retention_policy.key].retention_days

      # Optional
      backup_interval_in_hours = each.value.short_term_retention_policy[short_term_retention_policy.key].backup_interval_in_hours
    }
  }

  dynamic "threat_detection_policy" {

    for_each = each.value.threat_detection_policy != null ? range(length(each.value.threat_detection_policy)) : []

    content {
      # Required

      # Optional
      email_addresses            = each.value.threat_detection_policy[threat_detection_policy.key].email_addresses
      retention_days             = each.value.threat_detection_policy[threat_detection_policy.key].retention_days
      storage_endpoint           = each.value.threat_detection_policy[threat_detection_policy.key].storage_endpoint
      storage_account_access_key = each.value.threat_detection_policy[threat_detection_policy.key].storage_account_access_key
      disabled_alerts            = each.value.threat_detection_policy[threat_detection_policy.key].disabled_alerts
      email_account_admins       = each.value.threat_detection_policy[threat_detection_policy.key].email_account_admins
      state                      = each.value.threat_detection_policy[threat_detection_policy.key].state
    }
  }

  dynamic "import" {

    for_each = each.value.import != null ? range(length(each.value.import)) : []

    content {
      # Required
      storage_uri                  = each.value.import[import.key].storage_uri
      administrator_login_password = each.value.import[import.key].administrator_login_password
      administrator_login          = each.value.import[import.key].administrator_login
      storage_key                  = each.value.import[import.key].storage_key
      storage_key_type             = each.value.import[import.key].storage_key_type
      authentication_type          = each.value.import[import.key].authentication_type

      # Optional
      storage_account_id = each.value.import[import.key].storage_account_id
    }
  }

  dynamic "identity" {

    for_each = each.value.identity != null ? range(length(each.value.identity)) : []

    content {
      # Required
      identity_ids = each.value.identity[identity.key].identity_ids
      type         = each.value.identity[identity.key].type

      # Optional
    }
  }

  dynamic "long_term_retention_policy" {

    for_each = each.value.long_term_retention_policy != null ? range(length(each.value.long_term_retention_policy)) : []

    content {
      # Required

      # Optional
      monthly_retention = each.value.long_term_retention_policy[long_term_retention_policy.key].monthly_retention
      weekly_retention  = each.value.long_term_retention_policy[long_term_retention_policy.key].weekly_retention
      yearly_retention  = each.value.long_term_retention_policy[long_term_retention_policy.key].yearly_retention
      week_of_year      = each.value.long_term_retention_policy[long_term_retention_policy.key].week_of_year
    }
  }



  lifecycle {
    prevent_destroy = false
  }
}
