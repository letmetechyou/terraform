resource "azurerm_key_vault_secret" "name" {
  for_each     = { for key, value in local.linux_virtual_machine_data : key => value if value.enabled && value.disable_password_authentication == false && value.admin_ssh_key == null && value.admin_password == null }
  name         = "${each.key}-lnxvm"
  key_vault_id = each.value.key_vault_id
  value        = random_password.main["${each.key}"].result
}

resource "random_password" "main" {
  for_each = { for key, value in local.linux_virtual_machine_data : key => value if value.enabled && value.disable_password_authentication == false && value.admin_ssh_key == null && value.admin_password == null }
  length   = 20
}

resource "azurerm_linux_virtual_machine" "linux_virtual_machine" {
  for_each = { for key, value in local.linux_virtual_machine_data : key => value if value.enabled }

  # Required Arguments
  name = coalesce(
    try(each.value.name, null),
    try(each.key, null)
  )
  location = each.value.location
  network_interface_ids = coalesce(
    try(each.value.network_interface_ids, null),
    try([for nic in keys(each.value.network_interface_data) : var.network_interface_output["${each.key}${lookup(each.value.network_interface_data, nic).name_suffix}"].id if lookup(each.value.network_interface_data, nic).enabled], null),
    try([for nic in keys(each.value.network_interface_data) : module.network_interface.network_interface_output_names["${each.key}${lookup(each.value.network_interface_data, nic).name_suffix}"].id if lookup(each.value.network_interface_data, nic).enabled], null)
  )
  resource_group_name = coalesce(
    try(each.value.resource_group_name, null),
    try(var.resource_group_output["${each.value.existing_resource_group_name}"].name, null)
  )
  size           = each.value.size
  admin_username = each.value.admin_username



  # Required Blocks 

  os_disk {
    # Required
    storage_account_type = each.value.os_disk.storage_account_type
    caching              = each.value.os_disk.caching
    # Optional
    disk_size_gb = each.value.os_disk.disk_size_gb
    name = coalesce(
      try(each.value.os_disk.name, null),
      try("${each.key}${each.value.os_disk.name_suffix}", null)
    )
    secure_vm_disk_encryption_set_id = each.value.os_disk.secure_vm_disk_encryption_set_id
    security_encryption_type         = each.value.os_disk.security_encryption_type
    disk_encryption_set_id           = each.value.os_disk.disk_encryption_set_id
    write_accelerator_enabled        = each.value.os_disk.write_accelerator_enabled

    dynamic "diff_disk_settings" {
      for_each = each.value.os_disk.diff_disk_settings != null ? [1] : []

      content {
        option    = each.value.os_disk.diff_disk_settings.option
        placement = each.value.os_disk.diff_disk_settings.placement
      }

    }
  }


  # Optional Arguments
  admin_password = try(coalesce(
    try(each.value.admin_password, null),
    try(random_password.main["${each.key}"].result)
  ), null)
  allow_extension_operations = each.value.allow_extension_operations
  availability_set_id = try(
    coalesce(
      try(each.value.availability_set_id, null),
      try(module.availability_set.availability_set_output_names["${each.value.computer_name_prefix}${each.value.availability_set_data.name_suffix}"].id, null)
  ), null)
  bypass_platform_safety_checks_on_user_schedule_enabled = each.value.bypass_platform_safety_checks_on_user_schedule_enabled
  capacity_reservation_group_id                          = each.value.capacity_reservation_group_id
  computer_name = coalesce(
    try(each.value.computer_name, null),
    try(each.key, null)
  )
  custom_data                     = each.value.custom_data
  dedicated_host_group_id         = each.value.dedicated_host_group_id
  dedicated_host_id               = each.value.dedicated_host_id
  disable_password_authentication = each.value.disable_password_authentication
  edge_zone                       = each.value.edge_zone
  encryption_at_host_enabled      = each.value.encryption_at_host_enabled
  eviction_policy                 = each.value.eviction_policy
  extensions_time_budget          = each.value.extensions_time_budget
  license_type                    = each.value.license_type
  max_bid_price                   = each.value.max_bid_price
  patch_assessment_mode           = each.value.patch_assessment_mode
  patch_mode                      = each.value.patch_mode
  platform_fault_domain           = each.value.platform_fault_domain
  priority                        = each.value.priority
  provision_vm_agent              = each.value.provision_vm_agent
  proximity_placement_group_id    = each.value.proximity_placement_group_id
  reboot_setting                  = each.value.reboot_setting
  secure_boot_enabled             = each.value.secure_boot_enabled
  source_image_id                 = each.value.source_image_id
  tags                            = each.value.tags
  user_data                       = each.value.user_data
  virtual_machine_scale_set_id    = each.value.virtual_machine_scale_set_id
  vtpm_enabled                    = each.value.vtpm_enabled
  zone                            = each.value.zone

  # Optional Dynamic Blocks
  dynamic "identity" {

    for_each = each.value.identity != null ? [1] : []

    content {
      # Required
      type = each.value.identity.type

      # Optional
      identity_ids = each.value.identity.identity_ids
    }
  }

  dynamic "plan" {

    for_each = each.value.plan != null ? [1] : []

    content {
      # Required
      name      = each.value.plan.name
      publisher = each.value.plan.publisher
      product   = each.value.plan.product

      # Optional
    }
  }

  dynamic "secret" {

    for_each = each.value.secret != null ? range(length(each.value.secret)) : []

    content {
      # Required
      key_vault_id = each.value.secret[secret.key].key_vault_id

      # Required Block
      certificate {
        url = each.value.secret[secret.key].certificate.url
      }

      # Optional
    }
  }

  dynamic "admin_ssh_key" {

    for_each = try({ for k, v in each.value.admin_ssh_key : k => v if v.enabled }, {})
    iterator = ssh_key

    content {
      # Required
      username = each.value.admin_username
      public_key = coalesce(
        try(ssh_key.value.public_key, null),
        try(var.tls_private_key_output["${ssh_key.value.tls_private_key.existing_secret.key_name}"].public_key_openssh, null),
        try(ssh_key.value.tls_private_key.new_secret.unique_per_system == true ? module.tls_private_key.tls_private_key_output["${each.key}${ssh_key.value.tls_private_key.new_secret.name_suffix}"].public_key_openssh : null),
        try(ssh_key.value.tls_private_key.new_secret.unique_per_system == false ? module.tls_private_key.tls_private_key_output["${each.value.computer_name_prefix}${ssh_key.value.tls_private_key.new_secret.name_suffix}"].public_key_openssh : null)
      )

      # Optional
    }
  }

  dynamic "gallery_application" {

    for_each = each.value.gallery_application != null ? range(length(each.value.gallery_application)) : []

    content {
      # Required
      version_id = each.value.gallery_application[gallery_application.key].version_id

      # Optional
      order                  = each.value.gallery_application[gallery_application.key].order
      tag                    = each.value.gallery_application[gallery_application.key].tag
      configuration_blob_uri = each.value.gallery_application[gallery_application.key].configuration_blob_uri
    }
  }

  dynamic "additional_capabilities" {

    for_each = each.value.additional_capabilities != null ? [1] : []

    content {
      # Required

      # Optional
      ultra_ssd_enabled = each.value.additional_capabilities.ultra_ssd_enabled
    }
  }

  dynamic "boot_diagnostics" {

    for_each = each.value.boot_diagnostics != null ? [1] : []

    content {
      # Required

      # Optional
      storage_account_uri = each.value.boot_diagnostics.storage_account_uri
    }
  }

  dynamic "termination_notification" {

    for_each = each.value.termination_notification != null ? [1] : []

    content {
      # Required
      enabled = each.value.termination_notification.enabled

      # Optional
      timeout = each.value.termination_notification.timeout
    }
  }

  dynamic "source_image_reference" {

    for_each = each.value.source_image_reference != null ? [1] : []

    content {
      # Required
      version   = each.value.source_image_reference.version
      offer     = each.value.source_image_reference.offer
      sku       = each.value.source_image_reference.sku
      publisher = each.value.source_image_reference.publisher

      # Optional
    }
  }

  depends_on = [random_password.main]

  lifecycle {
    prevent_destroy = false
    ignore_changes  = [secret, admin_password, source_image_reference]
  }
}
