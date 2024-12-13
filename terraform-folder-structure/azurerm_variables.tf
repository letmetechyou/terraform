variable "api_management_data" {
  type = map(object({
    enabled                             = string
    custom_domain_enabled               = optional(bool, true)
    name                                = string
    env                                 = string
    location                            = string
    proxy_hostname                      = string
    resource_group_name                 = string
    publisher_email                     = string
    publisher_name                      = string
    sku_name                            = string
    public_ip_address_id                = optional(string)
    public_ip_address_name              = optional(string, null)
    existing_key_vault_id               = optional(string)
    existing_key_vault_certificate_name = optional(string)
    virtual_network_type                = string
    existing_virtual_network_subnet_id  = string
    sign_in_enabled                     = optional(bool, true)
    dnsdomain                           = string
  }))
  default = {}
}

variable "api_management_data_v2" {
  type = map(object({
    enabled                             = string
    name                                = string
    env                                 = string
    location                            = string
    gateway_hostname                    = string
    resource_group_name                 = string
    publisher_email                     = string
    publisher_name                      = string
    sku_name                            = string
    public_ip_address_id                = optional(string)
    public_ip_address_name              = optional(string, null)
    existing_key_vault_id               = optional(string)
    key_vault_name                      = optional(string)
    existing_key_vault_certificate_name = optional(string)
    virtual_network_type                = string
    existing_virtual_network_subnet_id  = optional(string)
    subnet_name                         = optional(string)
    virtual_network_subnet_output_name  = optional(string)
    sign_in_enabled                     = optional(bool, true)
    dnsdomain                           = string
    tags                                = optional(map(string))
  }))
  default = {}
}

variable "application_gateway_data" {
  type = map(object({
    # Required
    enabled             = bool
    location            = string
    name                = string
    resource_group_name = string

    # Optional
    enable_http2                      = optional(bool)
    fips_enabled                      = optional(bool)
    firewall_policy_id                = optional(string)
    force_firewall_policy_association = optional(bool)
    tags                              = optional(map(string))
    zones                             = optional(list(string))

    backend_address_pool = optional(map(object({
      enabled      = bool
      name         = string
      fqdns        = optional(list(string))
      ip_addresses = optional(list(string))
    })))
    backend_http_settings = optional(map(object({
      enabled               = bool
      cookie_based_affinity = string
      name                  = string
      port                  = number
      protocol              = string
      affinity_cookie_name  = optional(string)
      authentication_certificate = optional(list(object({
        data = string
        name = string
      })))
      connection_draining = optional(object({
        drain_timeout_sec = number
        enabled           = bool
      }))
      host_name                           = optional(string)
      path                                = optional(string)
      pick_host_name_from_backend_address = optional(bool)
      probe_name                          = optional(string)
      request_timeout                     = optional(number)
      trusted_root_certificate_names      = optional(list(string))
    })))
    frontend_ip_configuration = optional(map(object({
      enabled                         = bool
      name                            = string
      private_ip_address_allocation   = optional(string)
      private_ip_address              = optional(string)
      private_link_configuration_name = optional(string)
      public_ip_address_id            = optional(string)
      subnet_id                       = optional(string)
    })))
    frontend_port = optional(map(object({
      enabled = bool
      name    = string
      port    = number
    })))
    gateway_ip_configuration = optional(map(object({
      enabled   = bool
      name      = string
      subnet_id = string
    })))
    http_listener = optional(map(object({
      enabled                        = bool
      frontend_ip_configuration_name = string
      frontend_port_name             = string
      name                           = string
      protocol                       = string
      custom_error_configuration = optional(list(object({
        custom_error_page_url = string
        status_code           = number
      })))
      firewall_policy_id   = optional(string)
      host_name            = optional(string)
      host_names           = optional(list(string))
      require_sni          = optional(bool)
      ssl_certificate_name = optional(string)
      ssl_profile_name     = optional(string)
    })))
    request_routing_rule = optional(map(object({
      enabled                     = bool
      http_listener_name          = string
      name                        = string
      rule_type                   = string
      backend_address_pool_name   = optional(string)
      backend_http_settings_name  = optional(string)
      priority                    = optional(number)
      redirect_configuration_name = optional(string)
      rewrite_rule_set_name       = optional(string)
      url_path_map_name           = optional(string)
    })))
    sku = object({
      name     = string
      tier     = string
      capacity = optional(number)
    })
    authentication_certificate = optional(list(object({
      data = string
      name = string
    })))
    autoscale_configuration = optional(object({
      min_capacity = number
      max_capacity = optional(number)
    }))
    custom_error_configuration = optional(list(object({
      custom_error_page_url = string
      status_code           = number
    })))
    global = optional(object({
      request_buffering_enabled  = bool
      response_buffering_enabled = bool
    }))
    identity = optional(object({
      identity_ids = list(string)
      type         = string
    }))
    private_link_configuration = optional(list(object({
      ip_configuration = list(object({
        name                          = string
        primary                       = bool
        private_ip_address_allocation = string
        private_ip_address            = optional(string)
        subnet_id                     = string
      }))
      name = string
    })))
    probe = optional(list(object({
      interval            = number
      name                = string
      path                = string
      protocol            = string
      timeout             = number
      unhealthy_threshold = number
      host                = optional(string)
      match = optional(object({
        status_code = list(string)
        body        = optional(string)
      }))
      minimum_servers                           = optional(number)
      pick_host_name_from_backend_http_settings = optional(bool)
      port                                      = optional(number)
    })))
    redirect_configuration = optional(list(object({
      name                 = string
      redirect_type        = string
      include_path         = optional(bool)
      include_query_string = optional(bool)
      target_listener_name = optional(string)
      target_url           = optional(string)
    })))
    rewrite_rule_set = optional(list(object({
      name = string
      rewrite_rule = optional(list(object({
        name                          = string
        rule_sequence                 = number
        condition                     = optional(string)
        request_header_configuration  = optional(list(string))
        response_header_configuration = optional(list(string))
        url                           = optional(string)
      })))
    })))
    ssl_certificate = optional(list(object({
      name                = string
      data                = optional(string)
      key_vault_secret_id = optional(string)
      password            = optional(string)
    })))
    ssl_policy = optional(object({
      cipher_suites        = optional(list(string))
      disabled_protocols   = optional(list(string))
      min_protocol_version = optional(string)
      policy_name          = optional(string)
      policy_type          = optional(string)
    }))
    ssl_profile = optional(list(object({
      name = string
      ssl_policy = optional(object({
        cipher_suites        = optional(list(string))
        disabled_protocols   = optional(list(string))
        min_protocol_version = optional(string)
        policy_name          = optional(string)
        policy_type          = optional(string)
      }))
      trusted_client_certificate_names     = optional(list(string))
      verify_client_cert_issuer_dn         = optional(bool)
      verify_client_certificate_revocation = optional(bool)
    })))
    trusted_client_certificate = optional(list(object({
      data = string
      name = string
    })))
    trusted_root_certificate = optional(list(object({
      data                = optional(string)
      key_vault_secret_id = optional(string)
      name                = string
    })))
    url_path_map = optional(list(object({
      name = string
      path_rule = optional(list(object({
        name                        = string
        paths                       = list(string)
        backend_address_pool_name   = optional(string)
        backend_http_settings_name  = optional(string)
        firewall_policy_id          = optional(string)
        redirect_configuration_name = optional(string)
        rewrite_rule_set_name       = optional(string)
      })))
      default_backend_address_pool_name   = optional(string)
      default_backend_http_settings_name  = optional(string)
      default_redirect_configuration_name = optional(string)
      default_rewrite_rule_set_name       = optional(string)
    })))
    waf_configuration = optional(list(object({
      enabled          = bool
      firewall_mode    = string
      rule_set_version = string
      disabled_rule_group = optional(list(object({
        rule_group_name = string
        rules           = list(string)
      })))
      exclusion = optional(list(object({
        match_variable          = string
        selector_match_operator = optional(string)
        selector                = optional(string)
      })))
      file_upload_limit_mb     = optional(number)
      max_request_body_size_kb = optional(number)
      request_body_check       = optional(bool)
      rule_set_type            = optional(string)
    })))
  }))
  default = {}
}

variable "application_insights_data" {
  type = map(object({
    enabled             = bool
    name                = string
    resource_group_name = string
    location            = string
    application_type    = string
    retention_in_days   = number
    disable_ip_masking  = bool
    workspace_id        = string
  }))
  default = {}
}

variable "availability_set_data" {
  type = map(object({
    # Required
    enabled                      = bool
    resource_group_name          = optional(string)
    existing_resource_group_name = optional(string)
    name                         = string
    location                     = string

    # Optional
    managed                      = optional(bool)
    tags                         = optional(map(any))
    platform_update_domain_count = optional(number)
    platform_fault_domain_count  = optional(number)
    proximity_placement_group_id = optional(string)

    # Optional Dynamic Blocks
  }))
  default = {}
}

variable "azurerm_linux_virtual_machine_data" {
  type = map(object({
    # Required
    enabled                      = bool
    qty                          = number
    start                        = number
    computer_name_prefix         = optional(string)
    admin_username               = string
    location                     = string
    name                         = optional(string)
    network_interface_ids        = optional(list(string))
    resource_group_name          = optional(string)
    existing_resource_group_name = optional(string)
    size                         = string

    # Required Blocks
    os_disk = object({
      # Required
      caching              = string
      storage_account_type = string

      # Optional
      disk_encryption_set_id           = optional(string)
      disk_size_gb                     = optional(number)
      name                             = optional(string)
      name_suffix                      = optional(string)
      secure_vm_disk_encryption_set_id = optional(string)
      security_encryption_type         = optional(string)
      write_accelerator_enabled        = optional(bool)

      # Optional Block
      diff_disk_settings = optional(object({
        option    = string
        placement = optional(string)
      }))
    })

    # Optional
    admin_password                                         = optional(string)
    allow_extension_operations                             = optional(bool)
    availability_set_id                                    = optional(string)
    bypass_platform_safety_checks_on_user_schedule_enabled = optional(bool)
    capacity_reservation_group_id                          = optional(string)
    computer_name                                          = optional(string)
    custom_data                                            = optional(string)
    dedicated_host_group_id                                = optional(string)
    dedicated_host_id                                      = optional(string)
    disable_password_authentication                        = optional(bool, true)
    edge_zone                                              = optional(string)
    encryption_at_host_enabled                             = optional(bool)
    eviction_policy                                        = optional(string)
    extensions_time_budget                                 = optional(number)
    key_vault_id                                           = optional(string)
    key_vault_name                                         = optional(string)
    license_type                                           = optional(string)
    max_bid_price                                          = optional(number)
    patch_assessment_mode                                  = optional(string)
    patch_mode                                             = optional(string)
    platform_fault_domain                                  = optional(string)
    priority                                               = optional(string)
    provision_vm_agent                                     = optional(bool)
    proximity_placement_group_id                           = optional(string)
    reboot_setting                                         = optional(string)
    secure_boot_enabled                                    = optional(bool)
    source_image_id                                        = optional(string)
    tags                                                   = optional(map(any))
    user_data                                              = optional(string)
    virtual_machine_scale_set_id                           = optional(string)
    vtpm_enabled                                           = optional(bool)
    zone                                                   = optional(string)

    # Optional Dynamic Blocks
    additional_capabilities = optional(object({
      # Required

      # Optional
      ultra_ssd_enabled = optional(bool)
    }))

    admin_ssh_key = optional(map(object({
      # Required
      enabled = bool
      #username   = string # NOT USED - Defaults in resource code to each.value.admin_username per documentation
      public_key = optional(string)
      tls_private_key = optional(object({
        existing_secret = optional(object({
          key_name = string
        }))
        new_secret = optional(object({
          # Required
          unique_per_system = bool
          algorithm         = string

          # Optional
          name_suffix     = optional(string)
          rsa_bits        = optional(number)
          ecdsa_curve     = optional(string)
          tags            = optional(map(any))
          content_type    = optional(string)
          not_before_date = optional(string)
          expiration_date = optional(string)


          existing_key_vault = optional(object({
            # Optional
            key_vault_name = optional(string)
            key_vault_id   = optional(string)
          }))
          #   new_key_vault = map(object({
          #     # Required
          #     enabled             = bool
          #     tenant_id           = string
          #     sku_name            = string
          #     name                = optional(string)
          #     name_suffix         = optional(string)
          #     location            = string
          #     resource_group_name = string

          #     # Optional
          #     soft_delete_retention_days      = optional(number)
          #     enable_rbac_authorization       = optional(bool)
          #     purge_protection_enabled        = optional(bool)
          #     enabled_for_disk_encryption     = optional(bool)
          #     enabled_for_template_deployment = optional(bool)
          #     public_network_access_enabled   = optional(bool)
          #     enabled_for_deployment          = optional(bool)
          #     tags                            = optional(map(any))

          #     # Optional Dynamic Blocks
          #     access_policy = optional(list(object({
          #       # Required
          #       object_id = string
          #       tenant_id = string

          #       # Optional
          #       key_permissions         = optional(list(string))
          #       application_id          = optional(string)
          #       certificate_permissions = optional(list(string))
          #       storage_permissions     = optional(list(string))
          #       secret_permissions      = optional(list(string))
          #     })))

          #     contact = optional(list(object({
          #       # Required
          #       email = string

          #       # Optional
          #       phone = optional(string)
          #       name  = optional(string)
          #     })))

          #     network_acls = optional(list(object({
          #       # Required
          #       default_action = string
          #       bypass         = string

          #       # Optional
          #       ip_rules                   = optional(list(string))
          #       virtual_network_subnet_ids = optional(list(string))
          #     })))
          #   }))
        }))
      }))

      # Optional
    })))

    boot_diagnostics = optional(object({
      # Required

      # Optional
      storage_account_uri = optional(string, null)
    }))

    gallery_application = optional(list(object({
      # Required
      version_id = string

      # Optional
      order                  = optional(number)
      tag                    = optional(string)
      configuration_blob_uri = optional(string)
    })))

    identity = optional(object({
      # Required
      type = string

      # Optional
      identity_ids = optional(list(string))
    }))

    plan = optional(object({
      # Required
      name      = string
      publisher = string
      product   = string

      # Optional
    }))

    secret = optional(map(object({
      # Required
      key_vault_id = string

      # Required Block
      certificate = map(object({
        url = string
      }))

      # Optional
    })))

    source_image_reference = optional(object({
      # Required
      version   = string
      offer     = string
      sku       = string
      publisher = string

      # Optional
    }))

    termination_notification = optional(object({
      # Required
      enabled = bool

      # Optional
      timeout = optional(string)
    }))

    # Additional Resources
    # Availability Set
    availability_set_data = optional(object({
      # Required
      enabled     = bool
      name_suffix = string

      # Optional
      managed                      = optional(bool)
      tags                         = optional(map(any))
      platform_update_domain_count = optional(number)
      platform_fault_domain_count  = optional(number)
      proximity_placement_group_id = optional(string)

    }))

    # Extension(s)
    virtual_machine_extension_data = optional(map(object({
      # Required
      enabled              = bool
      type_handler_version = string
      type                 = string
      publisher            = string
      virtual_machine_name = optional(string)
      virtual_machine_key  = optional(string)
      name_suffix          = optional(string)

      # Optional

      # Optional Dynamic Blocks
      protected_settings_from_key_vault = optional(list(object({
        # Required
        source_vault_id = string
        secret_url      = string

        # Optional
      })))
    })))

    # Network Interface(s)
    network_interface_data = map(object({
      # Required
      enabled     = bool
      name_suffix = string

      # Required Blocks
      ip_configuration = map(object({
        # Required
        enabled                       = bool
        private_ip_address_allocation = string
        name_suffix                   = string

        # Optional
        private_ip_address_version                         = optional(string)
        public_ip_address_id                               = optional(string)
        gateway_load_balancer_frontend_ip_configuration_id = optional(string)
        subnet_id                                          = optional(string)
        subnet_name                                        = optional(string)
        private_ip_address                                 = optional(string)
        primary                                            = optional(bool)
      }))

      # Optional
      edge_zone                      = optional(string)
      auxiliary_mode                 = optional(string)
      dns_servers                    = optional(list(string))
      accelerated_networking_enabled = optional(bool)
      ip_forwarding_enabled          = optional(bool)
      auxiliary_sku                  = optional(string)
      internal_dns_name_label        = optional(string)
      tags                           = optional(map(any))
      network_security_group_name    = optional(string)
      network_security_group_id      = optional(string)

    }))

    # Managed Disk(s)
    managed_disk_data = optional(map(object({
      # Required
      enabled                   = bool
      name_suffix               = string
      create_option             = string
      storage_account_type      = string
      lun                       = number
      caching                   = optional(string, "None")
      write_accelerator_enabled = optional(string, false)

      # Optional
      storage_account_id                = optional(string)
      network_access_policy             = optional(string)
      disk_iops_read_write              = optional(number)
      disk_mbps_read_only               = optional(number)
      disk_iops_read_only               = optional(number)
      tier                              = optional(string)
      secure_vm_disk_encryption_set_id  = optional(string)
      security_type                     = optional(string)
      optimized_frequent_attach_enabled = optional(bool)
      os_type                           = optional(string)
      disk_size_gb                      = optional(number)
      source_resource_id                = optional(string)
      disk_encryption_set_id            = optional(string)
      hyper_v_generation                = optional(string)
      disk_access_id                    = optional(string)
      upload_size_bytes                 = optional(number)
      tags                              = optional(map(any))
      trusted_launch_enabled            = optional(bool)
      max_shares                        = optional(number)
      on_demand_bursting_enabled        = optional(bool)
      image_reference_id                = optional(string)
      logical_sector_size               = optional(number)
      zone                              = optional(string)
      public_network_access_enabled     = optional(string)
      gallery_image_reference_id        = optional(string)
      source_uri                        = optional(string)
      performance_plus_enabled          = optional(bool)
      disk_mbps_read_write              = optional(number)
      edge_zone                         = optional(string)

      encryption_settings = optional(object({
        disk_encryption_key = optional(object({
          source_vault_id = string
          secret_url      = string
        }))
        key_encryption_key = optional(object({
          source_vault_id = string
          key_url         = string
        }))
      }))

      # Optional Dynamic Blocks
    })))
  }))
  default = {}
}

variable "backup_policy_vm_data" {
  # type = map(object({

  #   # Required
  #   name                = string
  #   resource_group_name = string
  #   recovery_vault_name = string
  #   backup = object({
  #     frequency = string
  #     time      = number # 24hour format
  #   })

  #   # Optional
  #   policy_type                    = optional(string)
  #   timezone                       = optional(string)
  #   instant_restore_retention_days = optional(number)

  #   # Optional blocks
  #   instant_restore_resource_group = optional(map(any))
  #   retention_daily                = optional(number)
  #   retention_weekly               = optional(object(string))
  #   retention_monthly              = optional(number)
  #   retention_yearly               = optional(object(string))

  # }))

  default = {}
}

# CDN FrontDoor Profile
variable "cdn_frontdoor_data" {
  type = map(object({
    name                     = string
    resource_group_name      = string
    sku_name                 = string
    response_timeout_seconds = optional(string)
    tags                     = optional(map(string))
  }))
  default = {}
}
# ------------------



# ------------------
# CDN FrontDoor Endpoint
variable "cdn_frontdoor_endpoints_data" {
  description = "CDN FrontDoor Endpoints configurations."
  type = map(object({
    name                       = string
    cdn_frontdoor_profile_name = string
    prefix                     = optional(string)
    custom_resource_name       = optional(string)
    enabled                    = optional(bool, true)
    tags                       = optional(map(string))
  }))
  default = {}
}

# ------------------
# CDN FrontDoor Origin Groups
variable "cdn_frontdoor_origin_groups_data" {
  description = "CDN FrontDoor Origin Groups configurations."
  type = map(object({
    name                                                      = string
    cdn_frontdoor_profile_name                                = string
    custom_resource_name                                      = optional(string)
    session_affinity_enabled                                  = optional(bool, true)
    restore_traffic_time_to_healed_or_new_endpoint_in_minutes = optional(number, 10)
    health_probe = optional(object({
      interval_in_seconds = number
      path                = string
      protocol            = string
      request_type        = string
    }))
    load_balancing = optional(object({
      additional_latency_in_milliseconds = optional(number, 50)
      sample_size                        = optional(number, 4)
      successful_samples_required        = optional(number, 3)
    }), {})
  }))
  default = {}
}

# ------------------
# CDN FrontDoor Origins
variable "cdn_frontdoor_origins_data" {
  description = "CDN FrontDoor Origins configurations."
  type = map(object({
    name                           = string
    cdn_frontdoor_profile_name     = string
    cdn_frontdoor_origin_group     = string
    custom_resource_name           = optional(string)
    enabled                        = optional(bool, true)
    certificate_name_check_enabled = optional(bool, true)

    host_name          = string
    http_port          = optional(number, 80)
    https_port         = optional(number, 443)
    origin_host_header = optional(string)
    priority           = optional(number, 1)
    weight             = optional(number, 1)

    private_link = optional(object({
      request_message        = optional(string)
      target_type            = optional(string)
      location               = string
      private_link_target_id = string
    }))
  }))
  default = {}
}

# ------------------
# CDN FrontDoor Custom Domains
variable "cdn_frontdoor_custom_domains_data" {
  description = "CDN FrontDoor Custom Domains configurations."
  type = map(object({
    name                       = string
    custom_resource_name       = optional(string)
    cdn_frontdoor_profile_name = string
    host_name                  = string
    dns_zone_id                = optional(string)
    tls = optional(object({
      certificate_type         = optional(string, "ManagedCertificate")
      minimum_tls_version      = optional(string, "TLS12")
      cdn_frontdoor_secret_id  = optional(string)
      key_vault_certificate_id = optional(string)
    }), {})
  }))
  default = {}

  validation {
    condition = alltrue([
      for custom_domain in var.cdn_frontdoor_custom_domains_data :
      can(regex("^[a-zA-Z0-9][0-9A-Za-z-]*[a-zA-Z0-9]$", custom_domain.name)) &&
      length(custom_domain.name) >= 2 &&
      length(custom_domain.name) <= 260
    ])
    error_message = "Custom domain names must be between 2 and 260 characters in length, must begin with a letter or number, end with a letter or number and contain only letters, numbers and hyphens."
  }
}

# ------------------
# CDN FrontDoor Routes
variable "cdn_frontdoor_routes_data" {
  description = "CDN FrontDoor Routes configurations."
  type = map(object({
    name                 = string
    custom_resource_name = optional(string)
    enabled              = optional(bool, true)

    endpoint_name     = string
    origin_group_name = string
    origins_names     = list(string)

    forwarding_protocol = optional(string, "HttpsOnly")
    patterns_to_match   = optional(list(string), ["/*"])
    supported_protocols = optional(list(string), ["Http", "Https"])
    cache = optional(object({
      query_string_caching_behavior = optional(string, "IgnoreQueryString")
      query_strings                 = optional(list(string))
      compression_enabled           = optional(bool, false)
      content_types_to_compress     = optional(list(string))
    }))

    custom_domains_names = optional(list(string), [])
    origin_path          = optional(string, "/")
    rule_sets_names      = optional(list(string), [])

    https_redirect_enabled = optional(bool, true)
    link_to_default_domain = optional(bool, true)
  }))
  default = {}
}

# ------------------
# CDN FrontDoor Rule Sets + Rules
variable "cdn_frontdoor_rule_sets_data" {
  description = "CDN FrontDoor Rule Sets and associated Rules configurations."
  type = map(object({
    name                       = string
    custom_resource_name       = optional(string)
    cdn_frontdoor_profile_name = string
    rules = optional(list(object({
      name                        = string
      cdn_frontdoor_rule_set_name = string
      custom_resource_name        = optional(string)
      order                       = number
      behavior_on_match           = optional(string, "Continue")

      actions = object({
        url_rewrite_actions = optional(list(object({
          source_pattern          = optional(string)
          destination             = optional(string)
          preserve_unmatched_path = optional(bool, false)
        })), [])
        url_redirect_actions = optional(list(object({
          redirect_type        = string
          destination_hostname = string
          redirect_protocol    = optional(string, "MatchRequest")
          destination_path     = optional(string, "")
          query_string         = optional(string, "")
          destination_fragment = optional(string, "")
        })), [])
        route_configuration_override_actions = optional(list(object({
          cache_duration                = optional(string, "1.12:00:00")
          cdn_frontdoor_origin_group_id = optional(string)
          forwarding_protocol           = optional(string, "MatchRequest")
          query_string_caching_behavior = optional(string, "IgnoreQueryString")
          query_string_parameters       = optional(list(string))
          compression_enabled           = optional(bool, false)
          cache_behavior                = optional(string, "HonorOrigin")
        })), [])
        request_header_actions = optional(list(object({
          header_action = string
          header_name   = string
          value         = optional(string)
        })), [])
        response_header_actions = optional(list(object({
          header_action = string
          header_name   = string
          value         = optional(string)
        })), [])
      })

      conditions = optional(object({
        remote_address_conditions = optional(list(object({
          operator         = string
          negate_condition = optional(bool, false)
          match_values     = optional(list(string))
        })), [])
        request_method_conditions = optional(list(object({
          match_values     = list(string)
          operator         = optional(string, "Equal")
          negate_condition = optional(bool, false)
        })), [])
        query_string_conditions = optional(list(object({
          operator         = string
          negate_condition = optional(bool, false)
          match_values     = optional(list(string))
          transforms       = optional(list(string), ["Lowercase"])
        })), [])
        post_args_conditions = optional(list(object({
          post_args_name   = string
          operator         = string
          negate_condition = optional(bool, false)
          match_values     = optional(list(string))
          transforms       = optional(list(string), ["Lowercase"])
        })), [])
        request_uri_conditions = optional(list(object({
          operator         = string
          negate_condition = optional(bool, false)
          match_values     = optional(list(string))
          transforms       = optional(list(string), ["Lowercase"])
        })), [])
        request_header_conditions = optional(list(object({
          header_name      = string
          operator         = string
          negate_condition = optional(bool, false)
          match_values     = optional(list(string))
          transforms       = optional(list(string), ["Lowercase"])
        })), [])
        request_body_conditions = optional(list(object({
          operator         = string
          match_values     = list(string)
          negate_condition = optional(bool, false)
          transforms       = optional(list(string), ["Lowercase"])
        })), [])
        request_scheme_conditions = optional(list(object({
          operator         = optional(string, "Equal")
          negate_condition = optional(bool, false)
          match_values     = optional(string, "HTTP")
        })), [])
        url_path_conditions = optional(list(object({
          operator         = string
          negate_condition = optional(bool, false)
          match_values     = optional(list(string))
          transforms       = optional(list(string), ["Lowercase"])
        })), [])
        url_file_extension_conditions = optional(list(object({
          operator         = string
          negate_condition = optional(bool, false)
          match_values     = list(string)
          transforms       = optional(list(string), ["Lowercase"])
        })), [])
        url_filename_conditions = optional(list(object({
          operator         = string
          match_values     = list(string)
          negate_condition = optional(bool, false)
          transforms       = optional(list(string), ["Lowercase"])
        })), [])
        http_version_conditions = optional(list(object({
          match_values     = list(string)
          operator         = optional(string, "Equal")
          negate_condition = optional(bool, false)
        })), [])
        cookies_conditions = optional(list(object({
          cookie_name      = string
          operator         = string
          negate_condition = optional(bool, false)
          match_values     = optional(list(string))
          transforms       = optional(list(string), ["Lowercase"])
        })), [])
        is_device_conditions = optional(list(object({
          operator         = optional(string, "Equal")
          negate_condition = optional(bool, false)
          match_values     = optional(list(string), ["Mobile"])
        })), [])
        socket_address_conditions = optional(list(object({
          operator         = string
          negate_condition = optional(bool, false)
          match_values     = optional(list(string))
        })), [])
        client_port_conditions = optional(list(object({
          operator         = string
          negate_condition = optional(bool, false)
          match_values     = optional(list(string))
        })), [])
        server_port_conditions = optional(list(object({
          operator         = string
          match_values     = list(string)
          negate_condition = optional(bool, false)
        })), [])
        host_name_conditions = optional(list(object({
          operator     = string
          match_values = optional(list(string))
          transforms   = optional(list(string), ["Lowercase"])
        })), [])
        ssl_protocol_conditions = optional(list(object({
          match_values     = list(string)
          operator         = optional(string, "Equal")
          negate_condition = optional(bool, false)
        })), [])
      }), null)
    })), [])
  }))
  default = {}
}

# ------------------
# CDN FrontDoor Firewall Policies
variable "cdn_frontdoor_firewall_policies_data" {
  description = "CDN Frontdoor Firewall Policies configurations."
  type = map(object({
    name                              = string
    resource_group_name               = string
    sku_name                          = string
    custom_resource_name              = optional(string)
    enabled                           = optional(bool, true)
    mode                              = optional(string, "Prevention")
    redirect_url                      = optional(string)
    custom_block_response_status_code = optional(number)
    custom_block_response_body        = optional(string)
    tags                              = optional(map(string))
    custom_rules = optional(list(object({
      name                           = string
      action                         = string
      enabled                        = optional(bool, true)
      priority                       = number
      type                           = string
      rate_limit_duration_in_minutes = optional(number, 1)
      rate_limit_threshold           = optional(number, 10)
      match_conditions = list(object({
        match_variable   = string
        match_values     = list(string)
        operator         = string
        selector         = optional(string)
        negate_condition = optional(bool)
        transforms       = optional(list(string), [])
      }))
    })), [])
    managed_rules = optional(list(object({
      type    = string
      version = optional(string, "1.0")
      action  = string
      exclusions = optional(list(object({
        match_variable = string
        operator       = string
        selector       = string
      })), [])
      overrides = optional(list(object({
        rule_group_name = string
        exclusions = optional(list(object({
          match_variable = string
          operator       = string
          selector       = string
        })), [])
        rules = optional(list(object({
          rule_id = string
          action  = string
          enabled = optional(bool, true)
          exclusions = optional(list(object({
            match_variable = string
            operator       = string
            selector       = string
        })), []) })), [])
      })), [])
    })), [])
  }))
  default = {}
}

# ------------------
# CDN FrontDoor Security Policies
variable "cdn_frontdoor_security_policies_data" {
  description = "CDN FrontDoor Security policies configurations."
  type = map(object({
    name                       = string
    custom_resource_name       = optional(string)
    cdn_frontdoor_profile_name = string
    firewall_policy_name       = string
    patterns_to_match          = optional(list(string), ["/*"])
    custom_domain_names        = optional(list(string), [])
    endpoint_names             = optional(list(string), [])
  }))
  default = {}

  validation {
    condition = alltrue([
      for security_policy in var.cdn_frontdoor_security_policies_data :
      security_policy.custom_domain_names != null ||
      security_policy.endpoint_names != null
    ])
    error_message = "At least one custom domain name or endpoint name must be provided for all the security policies."
  }
}
variable "container_registry_data" {
  type = map(object({
    enabled                             = string
    name                                = string
    location                            = string
    resource_group_name                 = string
    sku                                 = string
    admin_enabled                 = optional(bool)
    public_network_access_enabled = optional(bool,false)
    tags                          = optional(map(any))
    export_policy_enabled         = optional(bool)
    zone_redundancy_enabled       = optional(bool)
    quarantine_policy_enabled     = optional(bool)
    anonymous_pull_enabled        = optional(bool)
    data_endpoint_enabled         = optional(bool)
    network_rule_bypass_option    = optional(string)
    retention_policy_days         = optional(number)
    trust_policy_enabled          = optional(bool)

    
    network_rule_set = optional(object({
      default_action = string
      ip_rule = optional(list(object({
        action = string
        ip_range = string
      })))
    }))
    identity = optional(object({
      type = string
      identity_ids = optional(list(string))
    }))
    georeplications = optional(object({
      location                  = string
      regional_endpoint_enabled = optional(bool)
      zone_redundancy_enabled   = optional(bool)
      tags                      = optional(map(any))
    }))
    encryption = optional(object({
      key_vault_key_id    = optional(string)
      identity_client_id  = optional(string)
    }))
  }))
  default = {}
}

variable "data_protection_backup_vault_data" {
  type = map(object({
    enabled             = bool
    name                = string
    resource_group_name = string
    location            = string
    datastore_type      = string
    redundancy          = string

    # Optional Dynamic Blocks
    identity = optional(object({
      type = string
    }))

    tags = optional(map(any))
  }))
  default = {}
}

variable "eventhub_data" {
  type = map(object({
    # Required
    enabled                   = bool
    resource_group_name       = string
    location                  = string
    message_retention         = number
    partition_count           = number
    environment               = string
    cmk_enabled               = optional(bool, false)
    key_vault_key_ids         = optional(list(string))
    key_name                  = optional(string)
    user_assigned_identity_id = optional(string)

    identity = optional(object({
      type         = optional(string, "UserAssigned")
      identity_ids = optional(list(string))
    }))

    # Either namespace or existing_namespace_name is required   
    existing_namespace_name = optional(string) # Use this parameter for a pre-existing namespace
    # Argument below creates a namespace
    namespace = optional(object({
      # Required
      sku      = string
      capacity = string
      # Optional
      name_override                 = optional(string)
      public_network_access_enabled = optional(bool)
      local_authentication_enabled  = optional(bool)
      dedicated_cluster_id          = optional(string)
      maximum_throughput_units      = optional(number)
      authorization_rule = optional(object({
        # Required
        name   = string
        listen = bool
        send   = bool
        manage = bool
      }))
    }))

    # Optional
    name_override = optional(string)
    status        = optional(string)
    authorization_rule = optional(object({
      # Required
      name   = string
      listen = bool
      send   = bool
      manage = bool
    }))

    private_endpoint = optional(object({
      # Required
      subnet_id           = string
      private_dns_zone_id = string
      tags                = optional(map(any))
    }))

    # Optional Dynamic Blocks
    capture_description = optional(object({
      # Required
      enabled  = bool
      encoding = string
      destination = object({
        name                = string
        archive_name_format = string
        blob_container_name = string
        storage_account_id  = string
      })

      #Optional
      skip_empty_archives = bool
      size_limit_in_bytes = number
      interval_in_seconds = number
    }))
    tags = optional(map(any))


  }))
  default = {}
}

variable "express_route_circuit_data" {
  type = map(object({
    enabled                  = bool
    import                   = optional(bool, false)
    import_resource_id       = optional(string)
    name                     = string
    resource_group_name      = string
    location                 = string
    service_provider_name    = optional(string)
    peering_location         = optional(string)
    bandwidth_in_mbps        = optional(string)
    allow_classic_operations = optional(string)
    express_route_port_id    = optional(string)
    bandwidth_in_gbps        = optional(string)
    authorization_key        = optional(string)
    sku = object({
      tier   = string
      family = string
    })
    tags = optional(map(any))
  }))
  default = {}
}

variable "express_route_circuit_authorization_data" {
  type = map(object({
    # Required
    enabled                    = bool
    import                           = optional(bool, false)
    import_resource_id               = optional(string)
    express_route_circuit_name = string
    resource_group_name        = string
    name                       = string

    # Optional

    # Optional Dynamic Blocks
  }))
  default = {}
}

variable "express_route_circuit_peering_data" {
  type = map(object({
    enabled                       = bool
    import                        = optional(bool, false)
    import_resource_id            = optional(string)
    peering_type                  = string
    express_route_circuit_name    = string
    resource_group_name           = string
    vlan_id                       = number
    primary_peer_address_prefix   = optional(string)
    secondary_peer_address_prefix = optional(string)
    ipv4_enabled                  = optional(bool)
    peer_asn                      = optional(number)
    microsoft_peering_config      = optional(object({
      advertised_public_prefixes = list(string)
      customer_asn = optional(number)
      routing_registry_name = optional(string)
      advertised_communities = optional(list(string))
    }))
  }))
  default = {}
}

variable "express_route_connection_data" {
  type = map(object({
    # Required
    enabled                          = bool
    import                           = optional(bool, false)
    import_resource_id               = optional(string)
    express_route_gateway_id         = string
    express_route_circuit_peering_id = string
    name                             = string

    # Optional
    express_route_gateway_bypass_enabled = optional(bool)
    routing_weight                       = optional(number)
    authorization_key                    = optional(string)
    enable_internet_security             = optional(bool)

    # Optional Dynamic Block
    routing = optional(list(object({
      # Required

      # Optional
      outbound_route_map_id     = optional(string)
      inbound_route_map_id      = optional(string)
      associated_route_table_id = optional(string)
      #block - propagated_route_table    = optional(string)
    })))
  }))
  default = {}
}

variable "firewall_data" {
  type = map(object({
    # Required
    enabled             = bool
    sku_name            = string
    sku_tier            = string
    location            = string
    resource_group_name = string
    name                = string

    # Optional
    firewall_policy_id   = optional(string)
    firewall_policy_name = optional(string)
    zones                = optional(list(string))
    tags                 = optional(map(any))
    private_ip_ranges    = optional(list(string))
    dns_servers          = optional(list(string))
    threat_intel_mode    = optional(string)

    # Optional Dynamic Blocks
    ip_configuration = optional(list(object({
      # Required
      name = string

      # Optional
      public_ip_address_id               = optional(string)
      public_ip_address_name             = optional(string)
      public_ip_address_key              = optional(string)
      subnet_id                          = optional(string)
      subnet_name                        = optional(string)
      virtual_network_subnet_output_name = optional(string)
      subnet_key                         = optional(string)
    })))

    virtual_hub = optional(list(object({
      # Required
      virtual_hub_id = string

      # Optional
      public_ip_count = optional(number)
    })))

    management_ip_configuration = optional(list(object({
      # Required
      public_ip_address_id               = optional(string)
      public_ip_address_name             = optional(string)
      public_ip_address_key              = optional(string)
      subnet_id                          = optional(string)
      subnet_name                        = optional(string)
      virtual_network_subnet_output_name = optional(string)
      subnet_key                         = optional(string)
      name                               = string

      # Optional
    })))
  }))
  default = {}
}

variable "firewall_policy_data" {
  type = map(object({
    # Required
    enabled             = bool
    location            = string
    name                = string
    resource_group_name = string

    # Optional
    base_policy_id = optional(string)

    dns = optional(object({
      proxy_enabled = bool
      servers       = list(string)
    }))

    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))

    insights = optional(object({
      enabled                            = bool
      default_log_analytics_workspace_id = string
      retention_in_days                  = number
      log_analytics_workspace = optional(list(object({
        id                = string
        firewall_location = string
      })))
    }))

    intrusion_detection = optional(object({
      mode = string
      signature_overrides = optional(list(object({
        id    = string
        state = string
      })))
      traffic_bypass = optional(list(object({
        name                  = string
        protocol              = string
        description           = optional(string)
        destination_addresses = optional(list(string))
        destination_ip_groups = optional(list(string))
        destination_ports     = optional(list(string))
        source_addresses      = optional(list(string))
        source_ip_groups      = optional(list(string))
      })))
      private_ranges = optional(list(string))
    }))

    private_ip_ranges                 = optional(list(string))
    auto_learn_private_ranges_enabled = optional(bool)
    sku                               = optional(string)
    tags                              = optional(map(any))

    threat_intelligence_allowlist = optional(object({
      fqdns        = optional(list(string))
      ip_addresses = optional(list(string))
    }))

    threat_intelligence_mode = optional(string)
    tls_certificate = optional(list(object({
      key_vault_secret_id = string
      name                = string
    })))

    sql_redirect_allowed = optional(bool)
    explicit_proxy = optional(object({
      enabled         = bool
      http_port       = optional(number)
      https_port      = optional(number)
      enable_pac_file = optional(bool)
      pac_file_port   = optional(number)
      pac_file        = optional(string)
    }))
  }))
  default = {}
}

variable "firewall_policy_rule_collection_group_data" {
  description = "Configuration for Azure Firewall Policy Rule Collection Group."

  type = map(object({
    # Required
    enabled              = bool
    name                 = string
    firewall_policy_id   = optional(string)
    firewall_policy_name = optional(string)
    priority             = number

    # Optional
    application_rule_collection = optional(object({
      name     = string
      action   = string
      priority = number

      rule = object({
        name                  = string
        description           = optional(string)
        protocols             = list(string)
        source_addresses      = optional(list(string))
        source_ip_groups      = optional(list(string))
        destination_addresses = optional(list(string))
        destination_urls      = optional(list(string))
        destination_fqdns     = optional(list(string))
        destination_fqdn_tags = optional(list(string))
        terminate_tls         = optional(bool)
        web_categories        = optional(list(string))
      })
    }))

    nat_rule_collection = optional(object({
      name     = string
      action   = string
      priority = number

      rule = object({
        name                = string
        protocols           = list(string)
        source_addresses    = optional(list(string))
        source_ip_groups    = optional(list(string))
        destination_address = optional(string)
        destination_ports   = list(string)
        translated_address  = optional(string)
        translated_fqdn     = optional(string)
        translated_port     = number
      })
    }))

    network_rule_collection = optional(object({
      name     = string
      action   = string
      priority = number

      rules = list(object({
        enabled               = bool
        name                  = string
        protocols             = list(string)
        destination_ports     = list(string)
        source_addresses      = optional(list(string))
        source_ip_groups      = optional(list(string))
        destination_addresses = optional(list(string))
        destination_ip_groups = optional(list(string))
        destination_fqdns     = optional(list(string))
      }))
    }))
  }))
  default = {}
}

variable "internalservices_api_management_custom_domain_data" {
  type = map(object({
    enabled           = bool
    api_management_id = string

    developer_portal = optional(list(object({
      host_name    = string
      certificate  = string
      key_vault_id = string
    })))

    management = optional(list(object({
      host_name    = string
      certificate  = string
      key_vault_id = string
    })))

    gateway = optional(list(object({
      host_name           = string
      certificate         = string
      key_vault_id        = string
      default_ssl_binding = bool
    })))

  }))
  default = {}
}

variable "key_vault_access_policy_data" {
  type = map(object({
    enabled                 = bool
    import                  = optional(bool, false)
    import_resource_id      = optional(string)
    existing_key_vault_id   = optional(string)
    key_vault_name          = optional(string)
    obj_id                  = optional(string)
    user_id                 = optional(string)
    group_id                = optional(string)
    service_principal_id    = optional(string)
    certificate_permissions = optional(list(string))
    key_permissions         = optional(list(string))
    secret_permissions      = optional(list(string))
    storage_permissions     = optional(list(string))
  }))
  default = {}
}

variable "key_vault_certificate_data" {
  type = map(object({
    enabled      = bool
    name         = string
    key_vault_id = string

    certificate = optional(object({
      contents = optional(string)
      password = optional(string)
    }))

    certificate_policy = optional(object({
      issuer_parameters = object({
        name = string
      })
      key_properties = object({
        exportable = bool
        key_type   = string
        reuse_key  = bool
        key_size   = optional(number)
        curve      = optional(string)
      })
      secret_properties = object({
        content_type = string
      })
      lifetime_action = optional(object({
        action = object({
          action_type = string
        })
        trigger = object({
          days_before_expiry  = optional(number)
          lifetime_percentage = optional(number)
        })
      }))
      x509_certificate_properties = optional(object({
        key_usage                 = list(string)
        subject                   = string
        validity_in_months        = number
        extended_key_usage        = optional(list(string))
        subject_alternative_names = optional(string)
      }))
    }))
    tags = optional(map(any))
  }))
  default = {}
}

variable "key_vault_data" {
  type = map(object({
    enabled                       = bool
    import                        = optional(bool, false)
    import_resource_id            = optional(string)
    location                      = string
    key_vault_name                = string
    existing_resource_group_name  = string
    allowed_ip_rules              = optional(list(string), null)
    allowed_subnet_ids            = optional(list(string), null)
    purge_protection_enabled      = optional(bool, false)
    tags                          = optional(map(any))
    public_network_access_enabled = optional(bool, false)
  }))
  default = {}
}

variable "key_vault_key_data" {
  type = map(object({
    # Required
    enabled            = bool
    import             = optional(bool, false)
    import_resource_id = optional(string)
    name               = string
    key_vault_id       = optional(string)
    key_vault_name     = optional(string)
    key_opts           = list(string)
    key_type           = string

    # Optional
    key_size        = optional(number)
    curve           = optional(string)
    not_before_date = optional(string)
    expiration_date = optional(string)
    tags            = optional(map(any))

    # Optional Dynamic Blocks
    rotation_policy = optional(list(object({
      # Required
      expire_after         = optional(string)
      notify_before_expiry = optional(string)

      # Optional Dynamic Blocks
      automatic = optional(object({
        # Required
        time_after_creation = optional(string)
        time_before_expiry  = optional(string)
      }))
    })))

  }))
  default = {}
}

variable "key_vault_managed_hardware_security_module_data" {
  type = map(object({
    enabled                                   = bool
    key_vault_name                            = string
    existing_resource_group_name              = string
    admin_object_ids                          = list(string)
    security_domain_key_vault_certificate_ids = optional(list(string))
    security_domain_quorum                    = optional(number)
    tags                                      = optional(map(any))
  }))
  default = {}
}

variable "key_vault_managed_hardware_security_module_role_assignment_data" {
  type = map(object({
    enabled            = bool
    scope              = string
    name               = string
    principal_id       = string
    role_definition_id = string
    managed_hsm_id     = string
    tags               = optional(map(any))
  }))
  default = {}
}

variable "key_vault_secret_data" {
  type = map(object({
    # Required
    name         = optional(string)
    value        = optional(string)
    key_vault_id = optional(string)

    #optional
    tags            = optional(map(any))
    content_type    = optional(string)
    not_before_date = optional(string)
    expiration_date = optional(string)
  }))
  default = {}
}

variable "lb_backend_address_pool_address_data" {
  type = map(object({
    # Required
    enabled                 = bool
    name                    = string
    backend_address_pool_id = string

    # Optional
    backend_address_ip_configuration_id = optional(string)
    ip_address                          = optional(string)
    virtual_network_id                  = optional(string)

    # Optional Dynamic Blocks
  }))
  default = {}
}

variable "lb_backend_address_pool_data" {
  type = map(object({
    # Required
    enabled           = bool
    name              = string
    loadbalancer_id   = optional(string)
    loadbalancer_name = optional(string)
    loadbalancer_key  = optional(string)

    # Optional
    virtual_network_id = optional(string)

    # Optional Dynamic Blocks
    tunnel_interface = optional(list(object({
      # Required
      port       = number
      identifier = string
      protocol   = string
      type       = string

      # Optional
    })))
  }))
  default = {}
}

variable "lb_data" {
  type = map(object({
    # Required
    enabled             = bool
    resource_group_name = string
    name                = string
    location            = string

    # Optional
    sku       = optional(string)
    sku_tier  = optional(string)
    edge_zone = optional(string)
    tags      = optional(map(any))

    # Separate variable for frontend_ip_configuration
    frontend_ip_configuration_data = optional(list(object({
      # Required
      name    = string
      lb_name = string

      # Optional
      zones                                              = optional(list(string))
      subnet_id                                          = optional(string)
      gateway_load_balancer_frontend_ip_configuration_id = optional(string)
      private_ip_address                                 = optional(string)
      private_ip_address_allocation                      = optional(string)
      private_ip_address_version                         = optional(string)
      public_ip_address_id                               = optional(string)
      public_ip_prefix_id                                = optional(string)
      public_ip_address_name                             = optional(string)
      public_ip_prefix_name                              = optional(string)
      public_ip_address_key                              = optional(string)
      public_ip_prefix_key                               = optional(string)
    })))
  }))
  default = {}
}

# FRONTEND CONFIGURATION VARIABLE
variable "lb_frontend_ip_configuration_data" {
  description = "Frontend IP Configuration data"

  type = map(object({
    # Required
    name    = string
    lb_name = string

    # Optional
    zones                                              = optional(list(string))
    subnet_id                                          = optional(string)
    subnet_name                                        = optional(string)
    virtual_network_subnet_output_name                 = optional(string)
    subnet_key                                         = optional(string)
    gateway_load_balancer_frontend_ip_configuration_id = optional(string)
    private_ip_address                                 = optional(string)
    private_ip_address_allocation                      = optional(string)
    private_ip_address_version                         = optional(string)
    public_ip_address_id                               = optional(string)
    public_ip_address_name                             = optional(string)
    public_ip_address_key                              = optional(string)

  }))
  default = {}
}

variable "lb_probe_data" {
  type = map(object({
    # Required
    enabled           = bool
    port              = number
    loadbalancer_id   = optional(string)
    loadbalancer_name = optional(string)
    loadbalancer_key  = optional(string)
    name              = string

    # Optional
    interval_in_seconds = optional(number)
    request_path        = optional(string)
    protocol            = optional(string)
    probe_threshold     = optional(number)
    number_of_probes    = optional(number)

    # Optional Dynamic Blocks
  }))
  default = {}
}

variable "lb_rule_data" {
  type = map(object({
    # Required
    enabled                        = bool
    name                           = string
    frontend_port                  = number
    protocol                       = string
    loadbalancer_id                = optional(string)
    loadbalancer_name              = optional(string)
    loadbalancer_key               = optional(string)
    frontend_ip_configuration_name = string
    backend_port                   = number

    # Optional
    probe_id                   = optional(string)
    probe_name                 = optional(string)
    probe_key                  = optional(string)
    disable_outbound_snat      = optional(bool)
    idle_timeout_in_minutes    = optional(number)
    load_distribution          = optional(string)
    backend_address_pool_ids   = optional(list(string))
    backend_address_pool_names = optional(list(string))
    backend_address_pool_keys  = optional(list(string))
    enable_tcp_reset           = optional(bool)
    enable_floating_ip         = optional(bool)

    # Optional Dynamic Blocks
  }))
  default = {}
}

variable "lb_outbound_rule_data" {
  type = map(object({
    # Required
    enabled                        = bool
    name                           = string
    protocol                       = string
    loadbalancer_id                = optional(string)
    loadbalancer_name              = optional(string)
    loadbalancer_key               = optional(string)
    frontend_ip_configuration = optional(list(object({
      name = string
    })))

    # Optional
    allocated_outbound_ports   = optional(number)
    probe_id                   = optional(string)
    probe_name                 = optional(string)
    probe_key                  = optional(string)
    disable_outbound_snat      = optional(bool)
    idle_timeout_in_minutes    = optional(number)
    backend_address_pool_id   = optional(string)
    backend_address_pool_name = optional(string)
    enable_tcp_reset           = optional(bool)

    # Optional Dynamic Blocks
  }))
  default = {}
}

variable "linux_virtual_machine_data" {
  type = map(object({
    enabled                         = bool
    existing_key_vault_id           = string
    location                        = string
    computer_name                   = string
    existing_resource_group_name    = string
    size                            = string
    secure_boot_enabled             = optional(string, false)
    existing_virtual_network        = string
    existing_virtual_network_rg     = string
    existing_virtual_network_subnet = string
    zone                            = optional(number, 1)
    tags                            = optional(map(any))
    os_disk = object({
      os_disk_caching              = string
      os_disk_storage_account_type = string
    })
    data_disk_storage_account_type = string
    data_disk_caching              = string
    data_disk_disk_size_gb         = number

    # Added for azurerm_marketplace_agreement
    plan = optional(object({
      publisher = string
      offer     = string
      plan      = string
      })
    )

    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })

    ip_configurations = list(object({
      name    = string
      primary = bool
    }))
  }))
  default = {}
}

variable "local_network_gateway_data" {
  type = map(object({
    # Required
    enabled             = bool
    name                = string
    location            = string
    resource_group_name = string

    # Optional
    gateway_fqdn    = optional(string)
    gateway_address = optional(string)
    address_space   = optional(list(string))

    # Optional Tags
    tags = optional(map(any))

    # Optional Dynamic Blocks
    bgp_settings = optional(list(object({
      # Required BGP Settings
      bgp_peering_address = string
      asn                 = number

      # Optional BGP Settings
      peer_weight = number
    })))
  }))
  default = {}
}

variable "log_analytics_workspace_data" {
  description = "A map of Log Analytics workspace data."
  type = map(object({
    # Required
    enabled             = bool,
    location            = string,
    resource_group_name = string,
    name                = string,

    #Optional
    internet_query_enabled             = optional(bool),
    reservation_capacity_in_gb_per_day = optional(number),
    sku                                = optional(string),
    local_authentication_disabled      = optional(bool),
    allow_resource_only_permissions    = optional(bool),
    cmk_for_query_forced               = optional(bool),
    internet_ingestion_enabled         = optional(bool),
    data_collection_rule_id            = optional(string),
    retention_in_days                  = optional(number),
    tags                               = optional(map(any)),
    daily_quota_gb                     = optional(number),
  }))
  default = {}
}

variable "managed_disk_data" {
  type = map(object({
    # Required
    enabled              = bool
    location             = string
    resource_group_name  = string
    name                 = string
    create_option        = string
    storage_account_type = string

    # Optional
    storage_account_id                = optional(string)
    network_access_policy             = optional(string)
    disk_iops_read_write              = optional(number)
    disk_mbps_read_only               = optional(number)
    disk_iops_read_only               = optional(number)
    tier                              = optional(string)
    secure_vm_disk_encryption_set_id  = optional(string)
    security_type                     = optional(string)
    optimized_frequent_attach_enabled = optional(bool)
    os_type                           = optional(string)
    disk_size_gb                      = optional(number)
    source_resource_id                = optional(string)
    disk_encryption_set_id            = optional(string)
    hyper_v_generation                = optional(string)
    disk_access_id                    = optional(string)
    upload_size_bytes                 = optional(number)
    tags                              = optional(map(any))
    trusted_launch_enabled            = optional(bool)
    max_shares                        = optional(number)
    on_demand_bursting_enabled        = optional(bool)
    image_reference_id                = optional(string)
    logical_sector_size               = optional(number)
    zone                              = optional(string)
    public_network_access_enabled     = optional(string)
    gallery_image_reference_id        = optional(string)
    source_uri                        = optional(string)
    performance_plus_enabled          = optional(bool)
    disk_mbps_read_write              = optional(number)
    edge_zone                         = optional(string)

    encryption_settings = optional(object({
      disk_encryption_key = optional(object({
        source_vault_id = string
        secret_url      = string
      }))
      key_encryption_key = optional(object({
        source_vault_id = string
        key_url         = string
      }))
    }))

    # Optional Dynamic Blocks
  }))
  default = {}
}

variable "management_lock_data" {
  type = map(object({
    # Required
    enabled    = bool
    lock_level = string
    scope      = optional(string)
    name       = optional(string)
    key        = optional(string)

    # Optional
    notes = optional(string)

    # Optional Dynamic Blocks
  }))
  default = {}
}

variable "marketplace_agreement_data" {
  type = map(object({
    # Required
    enabled   = bool
    plan      = string
    offer     = string
    publisher = string

    # Optional

    # Optional Dynamic Blocks
  }))
  default = {}
}

variable "monitor_activity_log_alert_data" {
  type = map(object({
    # Required
    enabled             = bool
    scopes              = list(string)
    name                = string
    resource_group_name = string
    location            = string

    # Required Blocks
    criteria = object({
      # Required
      category = string

      # Optional
      recommendation_impact   = optional(string)
      operation_name          = optional(string)
      recommendation_type     = optional(string)
      caller                  = optional(string)
      recommendation_category = optional(string)

      # Optional Mutually Exclusive Values (OR)
      level  = optional(string)
      levels = optional(list(string))

      resource_group  = optional(string)
      resource_groups = optional(list(string))

      resource_id  = optional(string)
      resource_ids = optional(list(string))

      resource_provider  = optional(string)
      resource_providers = optional(list(string))

      resource_type  = optional(string)
      resource_types = optional(list(string))

      status   = optional(string)
      statuses = optional(list(string))

      sub_status   = optional(string)
      sub_statuses = optional(list(string))

      # Optional Blocks
      resource_health = optional(object({
        # Required

        # Optional
        previous = optional(string)
        current  = optional(string)
        reason   = optional(string)
      }))

      service_health = optional(object({
        # Required

        # Optional
        locations = optional(list(string))
        events    = optional(list(string))
        services  = optional(list(string))
      }))
    })

    # Optional
    tags        = optional(map(any))
    description = optional(string)

    # Optional Dynamic Blocks
    action = optional(list(object({
      # Required
      action_group_name = string

      # Optional
      webhook_properties = optional(object({
        # Required

        # Optional
        service_uri             = optional(string)
        webhook_resource_id     = optional(string)
        use_common_alert_schema = optional(bool)
        custom_payload          = optional(string)
      }))
    })))
  }))
  default = {}
}

variable "monitor_diagnostic_setting_data" {
  type = map(object({
    # Required
    enabled            = bool
    name               = string
    target_resource_id = string

    # Optional
    log_analytics_workspace_id     = optional(string)
    storage_account_id             = optional(string)
    eventhub_name                  = optional(string)
    eventhub_authorization_rule_id = optional(string)
    log_analytics_destination_type = optional(string)
    partner_solution_id            = optional(string)

    # Optional Dynamic Blocks
    metric = optional(list(object({
      # Required
      category = string

      # Optional
      enabled = bool

      # Optional Dynamic Blocks
      retention_policy = optional(object({
        # Required
        enabled = bool

        # Optional
        days = number
      }))
    })))

    enabled_log = optional(list(object({
      # Required
      category_group = optional(string)
      category       = optional(string)

      # Optional Dynamic Blocks
      #retention_policy = optional(object({
      # Required
      #enabled = bool

      # Optional
      #days = optional(number)
      #}))
    })))
  }))
  default = {}
}

variable "mssql_firewall_rule_data" {
  type = map(object({
    enabled           = bool
    name              = string
    mssql_server_id   = optional(string)
    mssql_server_name = optional(string)
    mssql_server_key  = optional(string)
    start_ip_address  = string
    end_ip_address    = string
  }))
  default = {}
}
variable "mssql_database_data" {
  type = map(object({
    enabled   = bool
    name      = string
    server_id = string

  }))
  default = {}
}

variable "mssql_server_data" {
  type = map(object({
    enabled                                      = bool
    name                                         = string
    version                                      = string
    location                                     = string
    resource_group_name                          = string
    existing_key_vault_id                        = optional(string)
    connection_policy                            = optional(string)
    transparent_data_encryption_key_vault_key_id = optional(string)
    tags                                         = optional(map(any))
    public_network_access_enabled                = optional(bool)
    primary_user_assigned_identity_id            = optional(string)
    outbound_network_restriction_enabled         = optional(bool)
    minimum_tls_version                          = optional(number)
    administrator_login_password                 = optional(string)
    administrator_login                          = optional(string)
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    azuread_administrator = optional(object({
      login_username              = string
      object_id                   = string
      tenant_id                   = optional(string)
      azuread_authentication_only = optional(bool)

    }))
  }))
  default = {}
}

variable "mssql_server_extended_auditing_policy_data" {
  type = map(object({
    enabled_policy                          = bool
    mssql_server_id                         = optional(string)
    mssql_server_name                       = optional(string)
    mssql_server_key                        = optional(string)
    storage_account_access_key              = optional(string)
    retention_in_days                       = optional(number)
    storage_account_subscription_id         = optional(string)
    log_monitoring_enabled                  = optional(bool)
    enabled                                 = optional(bool)
    storage_account_access_key_is_secondary = optional(string)
    storage_endpoint                        = optional(string)
  }))
  default = {}
}

variable "mssql_server_security_alert_policy_data" {
  type = map(object({
    # Required
    enabled             = bool
    resource_group_name = string
    mssql_server_name   = optional(string)
    state               = string

    # Optional
    mssql_server_key           = optional(string)
    storage_account_name       = optional(string)
    email_addresses            = optional(set(string))
    email_account_admins       = optional(bool, true)
    storage_account_access_key = optional(string)
    retention_days             = optional(number, 365)
    storage_endpoint           = optional(string)
    disabled_alerts            = optional(set(string))
  }))
  default = {}
}

variable "mssql_server_vulnerability_assessment_data" {
  type = map(object({
    enabled                    = bool
    storage_container_name     = optional(string)
    storage_account_name       = optional(string)
    storage_account_access_key = optional(string)
    storage_container_sas_key  = optional(string)
    recurring_scans = optional(object({
      enabled                   = optional(bool)
      email_subscription_admins = optional(bool)
      email                     = optional(list(string))
    }))

  }))
  default = {}
}

variable "mssql_virtual_network_rule_data" {
  type = map(object({
    enabled                              = bool
    name                                 = string
    subnet_id                            = string
    mssql_server_id                      = optional(string)
    mssql_server_name                    = optional(string)
    mssql_server_key                     = optional(string)
    ignore_missing_vnet_service_endpoint = optional(bool)
  }))
  default = {}
}



variable "nat_gateway_data" {
  type = map(object({
    # Required
    enabled             = bool
    import              = optional(bool, false)
    import_resource_id  = optional(string)
    location            = string
    name                = string
    resource_group_name = string

    # Optional
    sku_name                = optional(string)
    zones                   = optional(list(string))
    tags                    = optional(map(any))
    idle_timeout_in_minutes = optional(number)

    # Optional Dynamic Blocks
  }))
  default = {}
}

variable "nat_gateway_public_ip_association_data" {
  type = map(object({
    # Required
    enabled                = bool
    import                 = optional(bool, false)
    import_resource_id     = optional(string)
    public_ip_address_id   = optional(string)
    public_ip_address_name = optional(string)
    nat_gateway_id         = optional(string)
    nat_gateway_name       = optional(string)

    # Optional
    # (No optional or dynamic blocks in this resource)
  }))
  default = {}
}

variable "nat_gateway_public_ip_prefix_association_data" {
  type = map(object({
    # Required
    enabled               = bool
    import                = optional(bool, false)
    import_resource_id    = optional(string)
    public_ip_prefix_id   = optional(string)
    public_ip_prefix_name = optional(string)
    nat_gateway_id        = optional(string)
    nat_gateway_name      = optional(string)

    # Optional
    # (No optional or dynamic blocks in this resource)
  }))
  default = {}
}

variable "network_interface_backend_address_pool_association_data" {
  type = map(object({
    # Required
    enabled                   = bool
    ip_configuration_name     = string
    network_interface_id      = optional(string)
    network_interface_name    = optional(string)
    network_interface_key     = optional(string)
    backend_address_pool_id   = optional(string)
    backend_address_pool_name = optional(string)
    backend_address_pool_key  = optional(string)

    # Optional
    # Add optional attributes if needed
  }))
  default = {}
}

variable "network_interface_data" {
  type = map(object({
    # Required
    enabled                      = bool
    name                         = string
    location                     = string
    resource_group_name          = optional(string)
    existing_resource_group_name = optional(string)

    # Required Blocks
    ip_configuration = object({
      # Required
      private_ip_address_allocation = string
      name                          = string

      # Optional
      private_ip_address_version                         = optional(string)
      public_ip_address_id                               = optional(string)
      gateway_load_balancer_frontend_ip_configuration_id = optional(string)
      subnet_id                                          = optional(string)
      private_ip_address                                 = optional(string)
      primary                                            = optional(bool)
    })

    # Optional
    edge_zone                      = optional(string)
    auxiliary_mode                 = optional(string)
    dns_servers                    = optional(list(string))
    accelerated_networking_enabled = optional(bool)
    ip_forwarding_enabled          = optional(bool)
    auxiliary_sku                  = optional(string)
    internal_dns_name_label        = optional(string)
    tags                           = optional(map(any))

    # Optional Dynamic Blocks
  }))
  default = {}
}

variable "network_interface_security_group_association_data" {
  type = map(object({
    # Required
    enabled                     = bool
    network_interface_name      = optional(string)
    network_security_group_name = optional(string)
    network_interface_id        = optional(string)
    network_security_group_id   = optional(string)
  }))
  default = {}
}

variable "network_security_group_data" {
  type = map(object({
    # Required
    enabled             = bool
    import              = optional(bool, false)
    import_resource_id  = optional(string)
    name                = string
    resource_group_name = string
    location            = string

    # Optional
    tags = optional(map(any))

    # Optional Dynamic Blocks
    security_rule = optional(list(object({
      # Required
      priority  = number
      direction = string
      protocol  = string
      access    = string
      name      = string

      # Optional
      source_port_ranges                         = optional(list(string))
      destination_port_range                     = optional(string)
      destination_port_ranges                    = optional(list(string))
      destination_application_security_group_ids = optional(list(string))
      source_application_security_group_ids      = optional(list(string))
      description                                = optional(string)
      source_address_prefix                      = optional(string)
      destination_address_prefix                 = optional(string)
      destination_address_prefixes               = optional(list(string))
      source_address_prefixes                    = optional(list(string))
      source_port_range                          = optional(string)
    })))
  }))
  default = {}
}

variable "network_security_rule_data" {
  type = map(object({
    # Required
    enabled                     = bool
    protocol                    = string
    priority                    = number
    access                      = string
    name                        = string
    network_security_group_name = string
    resource_group_name         = string
    direction                   = string

    # Required Blocks

    # Optional
    description                                = optional(string)
    source_application_security_group_ids      = optional(list(string))
    destination_application_security_group_ids = optional(list(string))

    source_port_range  = optional(string)
    source_port_ranges = optional(list(string))

    destination_port_range  = optional(string)
    destination_port_ranges = optional(list(string))

    source_address_prefix   = optional(string)
    source_address_prefixes = optional(list(string))

    destination_address_prefix   = optional(string)
    destination_address_prefixes = optional(list(string))

    # Optional Dynamic Blocks
  }))
  default = {}
}

variable "network_watcher_flow_log_data" {
  type = map(object({
    # Required
    enabled                     = bool
    network_watcher_name        = string
    resource_group_name         = string
    name                        = string
    network_security_group_id   = optional(string)
    network_security_group_name = optional(string)
    storage_account_id          = optional(string)
    storage_account_name        = optional(string)
    retention_policy = object({
      days    = number
      enabled = bool
    })

    # Optional
    location = optional(string)
    version  = optional(number)
    tags     = optional(map(any))

    # Optional Dynamic Blocks
    traffic_analytics = optional(list(object({
      # Required
      workspace_resource_id = string
      workspace_id          = string
      workspace_region      = string
      enabled               = bool

      # Optional
      interval_in_minutes = optional(number)

    })))
  }))
  default = {}
}

variable "palo_alto_data" {
  type = map(object({
    # Required
    qty                            = number
    start                          = number
    build                          = bool
    name_prefix                    = string
    resource_group_name            = string
    location                       = string
    vm_size                        = string
    existing_key_vault_id          = optional(string)
    existing_key_vault_secret_name = optional(string)

    # Optional
    availability_set_name = optional(string)
    plan = optional(object({
      name      = string
      publisher = string
      product   = string
    }))
    boot_diagnostics = optional(object({
      enabled     = bool
      storage_uri = string
    }))
    storage_image_reference = optional(object({
      publisher = optional(string)
      offer     = optional(string)
      sku       = optional(string)
      version   = optional(string)
      id        = optional(string)
    }))
    delete_os_disk_on_termination = optional(bool)
    storage_os_disk = optional(object({
      caching       = string
      create_option = string
    }))
    os_profile = optional(object({
      admin_username = string
      admin_password = optional(string)
      custom_data    = string
    }))
    network_configuration = optional(map(object({
      subnet                         = optional(string)
      private_ip_address_allocation  = optional(string)
      private_ip_address             = optional(string)
      public_ip                      = optional(bool)
      public_ip_prefix               = optional(string)
      dns                            = optional(bool)
      ip_forwarding_enabled          = optional(bool)
      accelerated_networking_enabled = optional(bool)
      lb                             = optional(bool)
      # Define the network configuration attributes here
    })))
    os_profile_linux_config = optional(object({
      disable_password_authentication = bool
      ssh_keys = optional(object({
        key_data = optional(string)
        key_name = optional(string)
        path     = string
      }))
    }))
    tags = optional(map(string))
  }))
  default = {}
}

variable "palo_alto_virtual_machine_data_disk_attachment_data" {
  type = map(object({
    # Required
    enabled              = bool
    managed_disk_id      = optional(string)
    managed_disk_name    = optional(string)
    managed_disk_key     = optional(string)
    lun                  = number
    virtual_machine_id   = optional(string)
    virtual_machine_name = optional(string)
    virtual_machine_key  = optional(string)
    caching              = string

    # Optional
    create_option             = optional(string)
    write_accelerator_enabled = optional(bool)

    # Optional Dynamic Blocks
  }))
  default = {}
}

variable "private_dns_resolver_data" {
  description = "Map of private DNS resolver configurations."

  type = map(object({

    # Required
    enabled             = bool
    resource_group_name = string
    name                = string
    location            = string

    # Required, but set as optional for interpolation of different values (id, name, key)
    virtual_network_id   = optional(string)
    virtual_network_name = optional(string)
    virtual_network_key  = optional(string)
    tags                 = optional(map(any))
  }))
  default = {}
}

variable "private_dns_resolver_dns_forwarding_ruleset_data" {
  type = map(object({
    # Required
    enabled                                      = bool
    private_dns_resolver_outbound_endpoint_ids   = optional(list(string))
    private_dns_resolver_outbound_endpoint_names = optional(list(string))
    private_dns_resolver_outbound_endpoint_keys  = optional(list(string))
    resource_group_name                          = string
    name                                         = string
    location                                     = string

    # Optional
    tags = optional(map(any))
  }))
  default = {}
}

variable "private_dns_resolver_forwarding_rule_data" {
  type = map(object({
    enabled                     = bool
    name                        = string
    domain_name                 = string
    dns_forwarding_ruleset_id   = optional(string)
    dns_forwarding_ruleset_name = optional(string)
    dns_forwarding_ruleset_key  = optional(string)

    target_dns_servers = list(object({
      ip_address = string
      port       = optional(number)
    }))

    metadata = optional(map(any))
  }))
  default = {}
}

variable "private_dns_resolver_inbound_endpoint_data" {
  type = map(object({
    # Required
    enabled                 = bool
    private_dns_resolver_id = string
    location                = string
    name                    = string
    ip_configurations = object({
      subnet_id = string
      # Optional
      private_ip_allocation_method = optional(string)
      private_ip_address           = optional(string)
    })
    # Optional
    tags = optional(map(any))
  }))
  default = {}
}


variable "private_dns_resolver_outbound_endpoint_data" {
  type = map(object({
    # Required
    enabled                            = bool
    name                               = string
    location                           = string
    private_dns_resolver_id            = optional(string)
    private_dns_resolver_name          = optional(string)
    private_dns_resolver_key           = optional(string)
    subnet_id                          = optional(string)
    subnet_name                        = optional(string)
    virtual_network_subnet_output_name = optional(string)
    subnet_key                         = optional(string)

    # Optional
    tags = optional(list(string))
  }))
  default = {}
}

variable "private_dns_resolver_virtual_network_link_data" {
  type = map(object({
    # Required
    enabled                     = bool
    name                        = string
    virtual_network_id          = optional(string)
    virtual_network_name        = optional(string)
    virtual_network_key         = optional(string)
    dns_forwarding_ruleset_id   = optional(string)
    dns_forwarding_ruleset_name = optional(string)
    dns_forwarding_ruleset_key  = optional(string)

    # Optional
    metadata = optional(string)
  }))
  default = {}
}

variable "private_endpoint_data" {
  type = map(object({
    enabled                            = bool
    import                             = optional(bool, false)
    import_resource_id                 = optional(string)
    name                               = string
    resource_group_name                = string
    location                           = string
    subnet_id                          = optional(string) #optional but required if not using subnet_name
    subnet_name                        = optional(string) #optional but required if not using subnet_id
    virtual_network_subnet_output_name = optional(string)
    custom_network_interface_name      = optional(string)
    private_dns_zone_group = optional(object({
      name                 = string
      private_dns_zone_ids = list(string)
    }))
    private_service_connection = object({
      name                              = string
      is_manual_connection              = bool
      private_connection_resource_id    = optional(string)
      private_connection_resource_alias = optional(string)
      subresource_names                 = optional(list(string))
    })
    tags = optional(map(any))

  }))
  default = {}
}

variable "public_ip_data" {
  type = map(object({
    # Required
    name                = string
    import              = optional(bool, false)
    import_resource_id  = optional(string)
    resource_group_name = string
    location            = string
    allocation_method   = string

    # Optional
    zones                   = optional(list(string))
    ddos_protection_mode    = optional(string)
    ddos_protection_plan_id = optional(string)
    domain_name_label       = optional(string)
    edge_zone               = optional(string)
    idle_timeout_in_minutes = optional(number)
    ip_tags                 = optional(map(any))
    ip_version              = optional(string)
    public_ip_prefix_id     = optional(string)
    reverse_fqdn            = optional(string)
    sku                     = optional(string)
    sku_tier                = optional(string)

    tags    = optional(map(any))
    enabled = optional(bool)
  }))
  default = {}
}

variable "public_ip_prefix_data" {
  type = map(object({
    # Required
    enabled             = bool
    import              = optional(bool, false)
    import_resource_id  = optional(string)
    location            = string
    name                = string
    resource_group_name = string

    # Optional
    tags          = optional(map(any))
    zones         = optional(list(string))
    sku           = optional(string)
    ip_version    = optional(string)
    prefix_length = optional(number)

    # Optional Dynamic Blocks
  }))
  default = {}
}

variable "recovery_services_vault_data" {
  type = map(object({
    # Required
    enabled             = bool
    name                = string
    resource_group_name = string
    location            = string
    sku                 = optional(string, "Standard")

    # Optional
    tags                               = optional(map(any))
    public_network_access_enabled      = optional(bool, false)
    immutability                       = optional(string)
    storage_mode_type                  = optional(string)
    cross_region_restore_enabled       = optional(bool)
    soft_delete_enabled                = optional(bool)
    classic_vmware_replication_enabled = optional(bool)

    # Optional Dynamic Blocks
    monitoring = optional(list(object({
      alerts_for_all_job_failures_enabled            = optional(bool)
      alerts_for_critical_operation_failures_enabled = optional(bool)
    })))

    encryption = optional(object({
      key_id                            = optional(string)
      infrastructure_encryption_enabled = optional(bool, true)
      user_assigned_identity_id         = optional(string)
      use_system_assigned_identity      = optional(bool, false)
    }))

    identity = optional(object({
      type         = optional(string, "UserAssigned")
      identity_ids = optional(list(string))
    }))

  }))
  default = {}
}

variable "resource_group_data" {
  type = map(object({
    #Required
    enabled            = bool
    import             = optional(bool, false)
    import_resource_id = optional(string)
    location           = string
    name               = string
    lock_level         = optional(string, "CanNotDelete")
    lock_enabled       = optional(bool, true)

    #Optional
    managed_by = optional(string)
    tags       = optional(map(any))
  }))
  default = {}
}

variable "role_assignment_data" {
  type = map(object({
    # Required
    enabled      = bool
    principal_id = string
    scope        = string

    # Optional
    role_definition_name                   = optional(string)
    condition                              = optional(string)
    description                            = optional(string)
    skip_service_principal_aad_check       = optional(bool)
    condition_version                      = optional(string)
    role_definition_id                     = optional(string)
    delegated_managed_identity_resource_id = optional(string)
    name                                   = optional(string)

    # Optional Dynamic Blocks
  }))
  default = {}
}

variable "route_table_data" {
  description = "A map of subnet associations with route tables"
  type = map(object({
    enabled                       = bool
    import                        = optional(bool, false)
    import_resource_id            = optional(string)
    name                          = string
    location                      = string
    resource_group_name           = optional(string)
    existing_resource_group_name  = optional(string)
    bgp_route_propagation_enabled = bool
    routes = optional(list(object({
      name                   = string
      address_prefix         = string
      next_hop_type          = string
      next_hop_in_ip_address = optional(string)
    })))
    tags = optional(map(any))
  }))
  default = {}
}

variable "security_center_contact_data" {
  type = map(object({
    enabled             = bool
    name                = string
    email               = string
    alert_notifications = optional(bool, true)
    alerts_to_admins    = optional(bool, true)
    phone_number        = string
  }))
  default = {}
}

variable "ssh_public_key_data" {
  type = map(object({
    # Required
    enabled             = bool
    resource_group_name = string
    location            = string
    name                = string
    public_key          = string

    # Optional
    tags = optional(map(any))
  }))
  default = {}
}

variable "storage_account_data" {
  type = map(object({
    # Required
    enabled                   = bool
    name                      = string
    account_replication_type  = string
    account_tier              = string
    location                  = string
    resource_group_name       = string
    cmk_enabled               = optional(bool, false) #var used for testing
    storage_account_id        = optional(string)      #temporarily optional
    key_vault_id              = optional(string)      #temporarily optional
    key_name                  = optional(string)      #temporarily optional
    user_assigned_identity_id = optional(string)      #temporarily optional

    # Optional
    queue_encryption_key_type         = optional(string, "Account") #Required for WIZ, update requires all storage accounts to be rebuilt *Do not change
    sftp_enabled                      = optional(bool)
    public_network_access_enabled     = optional(bool)
    table_encryption_key_type         = optional(string, "Account") #Required for WIZ, update requires all storage accounts to be rebuilt *Do not change
    edge_zone                         = optional(string)
    default_to_oauth_authentication   = optional(bool)
    shared_access_key_enabled         = optional(bool)
    large_file_share_enabled          = optional(bool)
    nfsv3_enabled                     = optional(bool)
    allow_nested_items_to_be_public   = optional(bool)
    https_traffic_only_enabled        = optional(bool)
    allowed_copy_scope                = optional(string)
    infrastructure_encryption_enabled = optional(bool, true)
    cross_tenant_replication_enabled  = optional(bool, false)
    min_tls_version                   = optional(string)
    access_tier                       = optional(string)
    tags                              = optional(map(any))
    is_hns_enabled                    = optional(bool)
    account_kind                      = optional(string)

    # Optional Dynamic Blocks
    network_rules = optional(object({
      default_action = string
      private_link_access = optional(list(object({
        id   = string
        name = string
      })))
      virtual_network_subnet_ids = optional(list(string))
      ip_rules                   = optional(list(string))
      bypass                     = optional(list(string))
    }))
    azure_files_authentication = optional(object({
      directory_type = string
      active_directory = optional(object({
        domain_guid         = string
        forest_name         = string
        domain_name         = string
        netbios_domain_name = string
      }))
    }))
    static_website = optional(object({
      index_document     = string
      error_404_document = string
    }))
    queue_properties = optional(object({
      hour_metrics = optional(object({
        enabled               = bool
        include_apis          = optional(bool)
        retention_policy_days = optional(number)
        version               = optional(string)
      }))
      logging = optional(object({
        delete                = optional(bool)
        read                  = optional(bool)
        write                 = optional(bool)
        retention_policy_days = optional(number)
        version               = optional(string)
      }))
      minute_metrics = optional(object({
        enabled               = bool
        include_apis          = optional(bool)
        retention_policy_days = optional(number)
        version               = optional(string)
      }))
      cors_rule = optional(list(object({
        allowed_headers    = list(string)
        allowed_methods    = list(string)
        allowed_origins    = list(string)
        exposed_headers    = list(string)
        max_age_in_seconds = number
      })))
    }))
    blob_properties = optional(object({
      change_feed_retention_in_days = optional(number)
      delete_retention_policy = optional(object({
        days    = optional(number, 30)
        enabled = optional(bool, true)
      }))
      change_feed_enabled = optional(bool)
      cors_rule = optional(list(object({
        allowed_headers    = list(string)
        allowed_methods    = list(string)
        allowed_origins    = list(string)
        exposed_headers    = list(string)
        max_age_in_seconds = number
      })))
      restore_policy = optional(object({
        days    = number
        enabled = bool
      }))
      versioning_enabled      = optional(bool)
      default_service_version = optional(string)
      container_delete_retention_policy = optional(object({
        days    = number
        enabled = bool
      }))
      last_access_time_enabled = optional(bool)
      }), {
      #Defaults
      delete_retention_policy = {}
      }
    )
    identity = optional(object({
      type         = string
      identity_ids = list(string)
    }))
    immutability_policy = optional(object({
      period_since_creation_in_days = number
      state                         = string
      allow_protected_append_writes = optional(bool)
    }))
    sas_policy = optional(object({
      expiration_period = string
      expiration_action = optional(string)
    }))
    custom_domain = optional(object({
      name          = string
      use_subdomain = optional(bool)
    }))
    share_properties = optional(object({
      smb = optional(object({
        enabled              = bool
        authentication_types = optional(list(string))
      }))
      cors_rule = optional(list(object({
        allowed_headers    = list(string)
        allowed_methods    = list(string)
        allowed_origins    = list(string)
        exposed_headers    = list(string)
        max_age_in_seconds = number
      })))
      retention_policy = optional(object({
        days    = number
        enabled = bool
      }))
    }))
    routing = optional(object({
      choice                      = string
      publish_internet_endpoints  = optional(bool)
      publish_microsoft_endpoints = optional(bool)
    }))
    # customer_managed_key = optional(object({
    #   user_assigned_identity_id = optional(string)
    #   key_vault_key_id          = optional(string)
    # }))
  }))
  default = {}
}

variable "storage_container_data" {
  type = map(object({
    # Required
    enabled              = bool
    storage_account_name = string
    name                 = string

    # Optional
    container_access_type = optional(string)
    metadata              = optional(map(any))

    # Optional Dynamic Blocks
  }))
  default = {}
}

variable "storage_share_data" {
  type = map(object({
    # Required
    enabled              = bool
    name                 = string
    quota                = number
    storage_account_name = string

    # Optional
    metadata         = optional(map(any))
    access_tier      = optional(string)
    enabled_protocol = optional(string)
    acl = optional(list(object({
      id = string
      access_policy = optional(object({
        permissions = string
        start       = optional(string)
        expiry      = optional(string)
      }))
    })))
  }))
  default = {}
}

variable "storage_share_directory_data" {
  type = map(object({
    enabled          = bool
    name             = string
    storage_share_id = string
    metadata         = optional(map(any))
  }))
  default = {}
}

variable "storage_share_file_data" {
  type = map(object({
    # Required
    enabled          = bool
    storage_share_id = string
    name             = string

    # Optional
    content_type        = optional(string)
    path                = optional(string)
    content_md5         = optional(string)
    metadata            = optional(map(any))
    content_disposition = optional(string)
    source              = optional(string)
    content_encoding    = optional(string)

    # Optional Dynamic Blocks
  }))
  default = {}
}

variable "subnet_data" {
  type = map(object({
    # Required
    enabled              = bool
    name                 = string
    import               = optional(bool, false)
    import_resource_id   = optional(string)
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)

    # Optional
    delegation = optional(object({
      name = string
      service_delegation = object({
        name    = string
        actions = list(string)
      })
    }))
    private_endpoint_network_policies             = optional(string, "Enabled")
    private_link_service_network_policies_enabled = optional(bool)
    service_endpoints                             = optional(list(string))
    service_endpoint_policy_ids                   = optional(list(string))

    # References / Association

    network_security_group_id   = optional(string)
    network_security_group_name = optional(string)
    network_security_group_key  = optional(string)
  }))
  default = {}
}

variable "subnet_nat_gateway_association_data" {
  type = map(object({
    # Required
    enabled = bool

    #optional but either id or name is required
    nat_gateway_id                     = optional(string)
    nat_gateway_name                   = optional(string)
    subnet_id                          = optional(string)
    subnet_name                        = optional(string)
    virtual_network_subnet_output_name = optional(string)

    # Optional
    # (No optional or dynamic blocks in this resource)
  }))
  default = {}
}

variable "subnet_network_security_group_association_data" {
  type = map(object({
    # Required
    enabled                            = bool
    import                             = optional(bool, false)
    import_resource_id                 = optional(string)
    subnet_id                          = optional(string)
    subnet_name                        = optional(string)
    virtual_network_subnet_output_name = optional(string)
    subnet_key                         = optional(string)
    network_security_group_id          = optional(string)
    network_security_group_name        = optional(string)
    network_security_group_key         = optional(string)

    # Optional

    # Optional Dynamic Blocks
  }))
  default = {}
}

variable "subnet_route_table_association_data" {
  type = map(object({

    # Required
    enabled                            = bool
    import                             = optional(bool, false)
    import_resource_id                 = optional(string)
    route_table_name                   = optional(string)
    route_table_key                    = optional(string)
    subnet_name                        = optional(string)
    virtual_network_subnet_output_name = optional(string)
    subnet_id                          = optional(string)
    route_table_id                     = optional(string)
  }))
  default = {}
}

variable "tls_private_key_data" {
  type = map(object({
    # Required
    enabled   = bool
    name      = string
    algorithm = string

    # Optional
    ecdsa_curve = optional(string)
    rsa_bits    = optional(number)
  }))
  default = {}
}

variable "user_assigned_identity_data" {
  type = map(object({
    # Required
    enabled             = bool
    import              = optional(bool, false)
    import_resource_id  = optional(string)
    name                = string
    location            = string
    resource_group_name = string

    # Optional
    tags = optional(map(any))
  }))
  default = {}
}

variable "virtual_machine_extension_data" {
  type = map(object({
    # Required - Marked as optional for interpolation of possible entries (id, name, key)
    enabled              = bool
    type_handler_version = string
    type                 = string
    publisher            = string
    virtual_machine_id   = optional(string)
    virtual_machine_name = optional(string)
    virtual_machine_key  = optional(string)
    name                 = string

    # Optional

    # Optional Dynamic Blocks
    protected_settings_from_key_vault = optional(list(object({
      # Required
      source_vault_id = string
      secret_url      = string

      # Optional
    })))
    tags = optional(map(any))
  }))
  default = {}
}

variable "virtual_network_data" {
  type = map(object({
    # Required
    enabled             = bool
    name                = string
    import              = optional(bool, false)
    import_resource_id  = optional(string)
    address_space       = list(string)
    location            = string
    resource_group_name = string

    # Optional
    bgp_community           = optional(string)
    dns_servers             = optional(list(string))
    edge_zone               = optional(string)
    flow_timeout_in_minutes = optional(number)
    ddos_protection_plan = optional(object({
      id     = string
      enable = bool
    }))
    encryption = optional(object({
      enforcement = string
    }))
    subnets = optional(list(object({
      enabled          = bool
      name             = string
      address_prefixes = string
      security_group   = optional(string)
    })))

    tags = optional(map(any))
  }))
  default = {}
}

variable "virtual_network_gateway_connection_data" {
  type = map(object({
    # Required
    enabled                    = bool
    import                     = optional(bool, false)
    import_resource_id         = optional(string)
    virtual_network_gateway_id = string
    type                       = string
    resource_group_name        = string
    name                       = string
    location                   = string


    # Optional
    authorization_key               = optional(string)
    authorization_key_name          = optional(string)
    connection_protocol             = optional(string)
    local_azure_ip_address_enabled  = optional(bool)
    shared_key                      = string #this used to be optional and may be fixed in a later release https://github.com/hashicorp/terraform-provider-azurerm/issues/27217
    routing_weight                  = optional(number)
    express_route_gateway_bypass    = optional(bool)
    enable_bgp                      = optional(bool)
    peer_virtual_network_gateway_id = optional(string)
    tags                            = optional(map(any))
    dpd_timeout_seconds             = optional(number)
    express_route_circuit_id        = optional(string)
    ingress_nat_rule_ids            = optional(list(string))
    connection_mode                 = optional(string)
    egress_nat_rule_ids             = optional(list(string))
    local_network_gateway_id        = optional(string)

    # Optional Dynamic Blocks
    ipsec_policy = optional(list(object({
      # Required
      ipsec_encryption = string
      pfs_group        = string
      ipsec_integrity  = string
      ike_encryption   = string
      ike_integrity    = string
      dh_group         = string

      # Optional
      sa_lifetime = optional(string)
      sa_datasize = optional(string)
    })))

    traffic_selector_policy = optional(list(object({
      # Required
      remote_address_cidrs = list(string)
      local_address_cidrs  = list(string)

      # Optional
    })))

    custom_bgp_addresses = optional(list(object({
      # Required
      primary = string

      # Optional
      secondary = optional(string)
    })))
  }))
  default = {}
}

variable "virtual_network_gateway_data" {
  type = map(object({
    # Required
    enabled             = bool
    import              = optional(bool, false)
    import_resource_id  = optional(string)
    name                = string
    resource_group_name = string
    location            = string
    sku                 = string
    type                = string
    # IP Configuration (Required)
    ip_configuration = list(object({
      # Required
      public_ip_address_id               = optional(string)
      subnet_id                          = optional(string)
      public_ip_address_name             = optional(string)
      subnet_name                        = optional(string)
      virtual_network_subnet_output_name = optional(string)

      # Optional
      name                          = optional(string)
      private_ip_address_allocation = optional(string)
    }))


    # Optional
    active_active                    = optional(bool)
    default_local_network_gateway_id = optional(string)
    edge_zone                        = optional(string)
    enable_bgp                       = optional(bool)
    generation                       = optional(string)
    private_ip_address_enabled       = optional(bool)
    virtual_wan_traffic_enabled      = optional(bool)
    remote_vnet_traffic_enabled      = optional(bool)
    tags                             = optional(map(any))

    # BGP Settings (Optional)
    bgp_settings = optional(object({
      asn = number

      peering_addresses = optional(object({
        ip_configuration_name = string
        apipa_addresses       = list(string)
      }))

      peer_weight = number
    }))

    # Custom Routes (Optional)
    custom_route = optional(object({
      address_prefixes = list(string)
    }))

    # VPN Client Configuration (Optional)
    vpn_client_configuration = optional(object({
      # Define your VPN client configuration attributes here if needed.
    }))

    # VPN Type (Optional)
    vpn_type = optional(string)
  }))
  default = {}
}

variable "virtual_network_gateway_nat_rule_data" {
  type = map(object({
    # Required
    enabled                    = bool
    virtual_network_gateway_id = string
    name                       = string
    resource_group_name        = string

    external_mapping = object({
      address_space = string
      # Optional
      port_range = optional(string)
    })

    internal_mapping = object({
      address_space = string
      # Optional
      port_range = optional(string)
    })
    # Optional
    type                = optional(string)
    ip_configuration_id = optional(string)
    mode                = optional(string)
  }))
  default = {}
}

variable "virtual_network_peering_data" {
  type = map(object({
    # Required
    enabled                   = bool
    import                    = optional(bool, false)
    import_resource_id        = optional(string)
    resource_group_name       = string
    remote_virtual_network_id = string
    name                      = string
    virtual_network_name      = string

    # Optional
    allow_gateway_transit        = optional(bool)
    allow_virtual_network_access = optional(bool)
    allow_forwarded_traffic      = optional(bool)
    triggers                     = optional(map(any))
    use_remote_gateways          = optional(bool)
  }))
  default = {}
}

variable "vngw_remote_express_route_circuit_authorization_data" {
  type = map(object({
    # Required
    enabled                    = bool
    express_route_circuit_name = string
    resource_group_name        = string
    name                       = string

    # Optional

    # Optional Dynamic Blocks
  }))
  default = {}
}

variable "windows_virtual_machine_data" {
  type = map(object({
    enabled                         = bool
    existing_key_vault_id           = optional(string)
    license_type                    = optional(string, "Windows_Server")
    location                        = string
    computer_name                   = string
    existing_resource_group_name    = string
    size                            = string
    secure_boot_enabled             = optional(string, false)
    existing_virtual_network        = string
    existing_virtual_network_rg     = string
    existing_virtual_network_subnet = string
    zone                            = optional(number, 1)
    os_disk = object({
      os_disk_caching              = string
      os_disk_storage_account_type = string
    })
    data_disk_storage_account_type = string
    data_disk_caching              = string
    data_disk_disk_size_gb         = number
    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
    ip_configurations = list(object({
      name                          = string
      primary                       = bool
      private_ip_address_allocation = optional(string, "Dynamic")
      private_ip_address            = optional(string)
    }))
    tags = optional(map(any))
  }))
  default = {}
}