
resource "azurerm_application_gateway" "application_gateway" {
  for_each = { for key, value in var.application_gateway_data : key => value if value.enabled }

  #Required Arguments
  location            = each.value.location
  name                = each.value.name
  resource_group_name = each.value.resource_group_name


  # Required Blocks 
  dynamic "backend_address_pool" {
    for_each = { for key, value in each.value.backend_address_pool : key => value if value.enabled }
    iterator = backend_address_pool

    content {
      # Required
      name = backend_address_pool.value.name
      # Optional
      fqdns        = backend_address_pool.value.fqdns
      ip_addresses = backend_address_pool.value.ip_addresses
    }
  }

  dynamic "backend_http_settings" {
    for_each = { for key, value in each.value.backend_http_settings : key => value if value.enabled }
    iterator = backend_http_settings
    content {
      # Required
      cookie_based_affinity = backend_http_settings.value.cookie_based_affinity
      name                  = backend_http_settings.value.name
      port                  = backend_http_settings.value.port
      protocol              = backend_http_settings.value.protocol
      # Optional
      affinity_cookie_name = backend_http_settings.value.affinity_cookie_name

      dynamic "authentication_certificate" {

        for_each = backend_http_settings.value.authentication_certificate != null ? range(length(backend_http_settings.value.authentication_certificate)) : []

        content {
          # Required
          name = backend_http_settings.value.authentication_certificate[authentication_certificate.key].name

          # Optional
        }
      }

      dynamic "connection_draining" {

        for_each = backend_http_settings.value.connection_draining != null ? [1] : []

        content {
          # Required
          drain_timeout_sec = backend_http_settings.value.connection_draining.drain_timeout_sec
          enabled           = backend_http_settings.value.connection_draining.enabled

          # Optional
        }
      }
      host_name                           = backend_http_settings.value.host_name
      path                                = backend_http_settings.value.path
      pick_host_name_from_backend_address = backend_http_settings.value.pick_host_name_from_backend_address
      probe_name                          = backend_http_settings.value.probe_name
      request_timeout                     = backend_http_settings.value.request_timeout
      trusted_root_certificate_names      = backend_http_settings.value.trusted_root_certificate_names
    }
  }

  dynamic "frontend_ip_configuration" {
    for_each = { for key, value in each.value.frontend_ip_configuration : key => value if value.enabled }
    iterator = frontend_ip_configuration

    content {
      # Required
      name = frontend_ip_configuration.value.name
      # Optional
      private_ip_address_allocation   = frontend_ip_configuration.value.private_ip_address_allocation
      private_ip_address              = frontend_ip_configuration.value.private_ip_address
      private_link_configuration_name = frontend_ip_configuration.value.private_link_configuration_name
      public_ip_address_id            = frontend_ip_configuration.value.public_ip_address_id
      subnet_id                       = frontend_ip_configuration.value.subnet_id
    }
  }

  dynamic "frontend_port" {
    for_each = { for key, value in each.value.frontend_port : key => value if value.enabled }
    iterator = frontend_port

    content {
      # Required
      name = frontend_port.value.name
      port = frontend_port.value.port
      # Optional
    }
  }

  dynamic "gateway_ip_configuration" {
    for_each = { for key, value in each.value.gateway_ip_configuration : key => value if value.enabled }
    iterator = gateway_ip_configuration

    content {
      # Required
      name      = gateway_ip_configuration.value.name
      subnet_id = gateway_ip_configuration.value.subnet_id
      # Optional
    }
  }

  dynamic "http_listener" {
    for_each = { for key, value in each.value.http_listener : key => value if value.enabled }
    iterator = http_listener

    content {
      # Required
      frontend_ip_configuration_name = http_listener.value.frontend_ip_configuration_name
      frontend_port_name             = http_listener.value.frontend_port_name
      name                           = http_listener.value.name
      protocol                       = http_listener.value.protocol
      # Optional
      dynamic "custom_error_configuration" {

        for_each = http_listener.value.custom_error_configuration != null ? range(length(http_listener.value.custom_error_configuration)) : []

        content {
          # Required
          custom_error_page_url = http_listener.value.custom_error_configuration[custom_error_configuration.key].custom_error_page_url
          status_code           = http_listener.value.custom_error_configuration[custom_error_configuration.key].status_code

          # Optional
        }
      }

      firewall_policy_id   = http_listener.value.firewall_policy_id
      host_name            = http_listener.value.host_name
      host_names           = http_listener.value.host_names
      require_sni          = http_listener.value.require_sni
      ssl_certificate_name = http_listener.value.ssl_certificate_name
      ssl_profile_name     = http_listener.value.ssl_profile_name
    }
  }

  dynamic "request_routing_rule" {
    for_each = { for key, value in each.value.request_routing_rule : key => value if value.enabled }
    iterator = request_routing_rule

    content {
      # Required
      http_listener_name = request_routing_rule.value.http_listener_name
      name               = request_routing_rule.value.name
      rule_type          = request_routing_rule.value.rule_type
      # Optional
      backend_address_pool_name   = request_routing_rule.value.backend_address_pool_name
      backend_http_settings_name  = request_routing_rule.value.backend_http_settings_name
      priority                    = request_routing_rule.value.priority
      redirect_configuration_name = request_routing_rule.value.redirect_configuration_name
      rewrite_rule_set_name       = request_routing_rule.value.rewrite_rule_set_name
      url_path_map_name           = request_routing_rule.value.url_path_map_name
    }
  }

  sku {
    # Required
    name = each.value.sku.name
    tier = each.value.sku.tier
    # Optional
    capacity = each.value.sku.capacity
  }


  # Optional Arguments
  enable_http2                      = each.value.enable_http2
  fips_enabled                      = each.value.fips_enabled
  firewall_policy_id                = each.value.firewall_policy_id
  force_firewall_policy_association = each.value.force_firewall_policy_association
  tags                              = each.value.tags
  zones                             = each.value.zones


  # Optional Dynamic Blocks
  dynamic "authentication_certificate" {

    for_each = each.value.authentication_certificate != null ? range(length(each.value.authentication_certificate)) : []

    content {
      # Required
      data = each.value.authentication_certificate[authentication_certificate.key].data
      name = each.value.authentication_certificate[authentication_certificate.key].name

      # Optional
    }
  }

  dynamic "autoscale_configuration" {

    for_each = each.value.autoscale_configuration != null ? [1] : []

    content {
      # Required
      min_capacity = each.value.autoscale_configuration.min_capacity

      # Optional
      max_capacity = each.value.autoscale_configuration.max_capacity
    }
  }

  dynamic "custom_error_configuration" {

    for_each = each.value.custom_error_configuration != null ? range(length(each.value.custom_error_configuration)) : []

    content {
      # Required
      custom_error_page_url = each.value.custom_error_configuration[custom_error_configuration.key].custom_error_page_url
      status_code           = each.value.custom_error_configuration[custom_error_configuration.key].status_code

      # Optional
    }
  }

  dynamic "global" {

    for_each = each.value.global != null ? [1] : []

    content {
      # Required
      request_buffering_enabled  = each.value.global.request_buffering_enabled
      response_buffering_enabled = each.value.global.response_buffering_enabled

      # Optional
    }
  }

  dynamic "identity" {

    for_each = each.value.identity != null ? [1] : []

    content {
      # Required
      identity_ids = each.value.identity.identity_ids
      type         = each.value.identity.type

      # Optional
    }
  }

  dynamic "private_link_configuration" {

    for_each = each.value.private_link_configuration != null ? range(length(each.value.private_link_configuration)) : []

    content {
      # Required
      name = each.value.private_link_configuration[private_link_configuration.key].name

      dynamic "ip_configuration" {
        for_each = range(length(each.value.private_link_configuration[private_link_configuration.key].ip_configuration))

        content {
          # Required
          name                          = each.value.private_link_configuration[private_link_configuration.key].ip_configuration[ip_configuration.key].name
          primary                       = each.value.private_link_configuration[private_link_configuration.key].ip_configuration[ip_configuration.key].primary
          private_ip_address_allocation = each.value.private_link_configuration[private_link_configuration.key].ip_configuration[ip_configuration.key].private_ip_address_allocation
          subnet_id                     = each.value.private_link_configuration[private_link_configuration.key].ip_configuration[ip_configuration.key].subnet_id
          # Optional
          private_ip_address = each.value.private_link_configuration[private_link_configuration.key].ip_configuration[ip_configuration.key].private_ip_address
        }
      }
    }
  }

  dynamic "probe" {

    for_each = each.value.probe != null ? range(length(each.value.probe)) : []

    content {
      # Required
      interval            = each.value.probe[probe.key].interval
      name                = each.value.probe[probe.key].name
      path                = each.value.probe[probe.key].path
      protocol            = each.value.probe[probe.key].protocol
      timeout             = each.value.probe[probe.key].timeout
      unhealthy_threshold = each.value.probe[probe.key].unhealthy_threshold

      # Optional
      host = each.value.probe[probe.key].host
      # match                                     = each.value.probe[probe.key].match
      dynamic "match" {

        for_each = each.value.probe[probe.key].match != null ? [1] : []

        content {
          # Required
          status_code = each.value.probe[probe.key].match.status_code

          # Optional
          body = each.value.probe[probe.key].match.body
        }
      }

      minimum_servers                           = each.value.probe[probe.key].minimum_servers
      pick_host_name_from_backend_http_settings = each.value.probe[probe.key].pick_host_name_from_backend_http_settings
      port                                      = each.value.probe[probe.key].port
    }
  }

  dynamic "redirect_configuration" {

    for_each = each.value.redirect_configuration != null ? range(length(each.value.redirect_configuration)) : []

    content {
      # Required
      name          = each.value.redirect_configuration[redirect_configuration.key].name
      redirect_type = each.value.redirect_configuration[redirect_configuration.key].redirect_type

      # Optional
      include_path         = each.value.redirect_configuration[redirect_configuration.key].include_path
      include_query_string = each.value.redirect_configuration[redirect_configuration.key].include_query_string
      target_listener_name = each.value.redirect_configuration[redirect_configuration.key].target_listener_name
      target_url           = each.value.redirect_configuration[redirect_configuration.key].target_url
    }
  }

  dynamic "rewrite_rule_set" {

    for_each = each.value.rewrite_rule_set != null ? range(length(each.value.rewrite_rule_set)) : []

    content {
      # Required
      name = each.value.rewrite_rule_set[rewrite_rule_set.key].name


      # Optional
      dynamic "rewrite_rule" {

        for_each = each.value.rewrite_rule_set[rewrite_rule_set.key].rewrite_rule != null ? range(length(each.value.rewrite_rule_set[rewrite_rule_set.key].rewrite_rule)) : []

        content {
          # Required
          name          = each.value.rewrite_rule_set[rewrite_rule_set.key].rewrite_rule[rewrite_rule.key].name
          rule_sequence = each.value.rewrite_rule_set[rewrite_rule_set.key].rewrite_rule[rewrite_rule.key].rule_sequence

          # Optional
          dynamic "condition" {

            for_each = each.value.rewrite_rule_set[rewrite_rule_set.key].rewrite_rule[rewrite_rule.key].condition != null ? range(length(each.value.rewrite_rule_set[rewrite_rule_set.key].rewrite_rule[rewrite_rule.key].condition)) : []

            content {
              # Required
              pattern  = each.value.rewrite_rule_set[rewrite_rule_set.key].rewrite_rule[rewrite_rule.key].condition[condition.key].pattern
              variable = each.value.rewrite_rule_set[rewrite_rule_set.key].rewrite_rule[rewrite_rule.key].condition[condition.key].variable

              # Optional
              ignore_case = each.value.rewrite_rule_set[rewrite_rule_set.key].rewrite_rule[rewrite_rule.key].condition[condition.key].ignore_case
              negate      = each.value.rewrite_rule_set[rewrite_rule_set.key].rewrite_rule[rewrite_rule.key].condition[condition.key].negate
            }
          }

          dynamic "request_header_configuration" {

            for_each = each.value.rewrite_rule_set[rewrite_rule_set.key].rewrite_rule[rewrite_rule.key].request_header_configuration != null ? range(length(each.value.rewrite_rule_set[rewrite_rule_set.key].rewrite_rule[rewrite_rule.key].request_header_configuration)) : []

            content {
              # Required
              header_name  = each.value.rewrite_rule_set[rewrite_rule_set.key].rewrite_rule[rewrite_rule.key].request_header_configuration[request_header_configuration.key].header_name
              header_value = each.value.rewrite_rule_set[rewrite_rule_set.key].rewrite_rule[rewrite_rule.key].request_header_configuration[request_header_configuration.key].header_value

              # Optional
            }
          }

          dynamic "response_header_configuration" {

            for_each = each.value.rewrite_rule_set[rewrite_rule_set.key].rewrite_rule[rewrite_rule.key].response_header_configuration != null ? range(length(each.value.rewrite_rule_set[rewrite_rule_set.key].rewrite_rule[rewrite_rule.key].response_header_configuration)) : []

            content {
              # Required
              header_name  = each.value.rewrite_rule_set[rewrite_rule_set.key].rewrite_rule[rewrite_rule.key].response_header_configuration[response_header_configuration.key].header_name
              header_value = each.value.rewrite_rule_set[rewrite_rule_set.key].rewrite_rule[rewrite_rule.key].response_header_configuration[response_header_configuration.key].header_value

              # Optional
            }
          }

          dynamic "url" {

            for_each = each.value.rewrite_rule_set[rewrite_rule_set.key].rewrite_rule[rewrite_rule.key].url != null ? [1] : []

            content {
              # Required

              # Optional
              components   = each.value.rewrite_rule_set[rewrite_rule_set.key].rewrite_rule[rewrite_rule.key].url.components
              path         = each.value.rewrite_rule_set[rewrite_rule_set.key].rewrite_rule[rewrite_rule.key].url.path
              query_string = each.value.rewrite_rule_set[rewrite_rule_set.key].rewrite_rule[rewrite_rule.key].url.query_string
              reroute      = each.value.rewrite_rule_set[rewrite_rule_set.key].rewrite_rule[rewrite_rule.key].url.reroute
            }
          }
        }
      }
    }
  }

  dynamic "ssl_certificate" {

    for_each = each.value.ssl_certificate != null ? range(length(each.value.ssl_certificate)) : []

    content {
      # Required
      name = each.value.ssl_certificate[ssl_certificate.key].name

      # Optional
      data                = each.value.ssl_certificate[ssl_certificate.key].key_vault_secret_id == null ? each.value.ssl_certificate[ssl_certificate.key].data : null
      key_vault_secret_id = each.value.ssl_certificate[ssl_certificate.key].key_vault_secret_id
      password            = each.value.ssl_certificate[ssl_certificate.key].data != null ? each.value.ssl_certificate[ssl_certificate.key].password : null
    }
  }

  dynamic "ssl_policy" {

    for_each = each.value.ssl_policy != null ? [1] : []

    content {
      # Required

      # Optional
      cipher_suites        = each.value.ssl_policy.cipher_suites
      disabled_protocols   = each.value.ssl_policy.policy_name != null ? each.value.ssl_policy.policy_type != null ? each.value.ssl_policy.disabled_protocols : null : null
      min_protocol_version = each.value.ssl_policy.min_protocol_version
      policy_name          = each.value.ssl_policy.policy_name
      policy_type          = each.value.ssl_policy.policy_name != null ? each.value.ssl_policy.disabled_protocols == null ? each.value.ssl_policy.policy_type : null : null
    }
  }

  dynamic "ssl_profile" {

    for_each = each.value.ssl_profile != null ? range(length(each.value.ssl_profile)) : []

    content {
      # Required
      name = each.value.ssl_profile[ssl_profile.key].name

      # Optional
      dynamic "ssl_policy" {

        for_each = each.value.ssl_profile[ssl_profile.key].ssl_policy != null ? [1] : []

        content {
          # Required

          # Optional
          cipher_suites        = each.value.ssl_profile[ssl_profile.key].ssl_policy.cipher_suites
          disabled_protocols   = each.value.ssl_profile[ssl_profile.key].ssl_policy.policy_name != null ? each.value.ssl_profile[ssl_profile.key].ssl_policy.policy_type != null ? each.value.ssl_profile[ssl_profile.key].ssl_policy.disabled_protocols : null : null
          min_protocol_version = each.value.ssl_profile[ssl_profile.key].ssl_policy.min_protocol_version
          policy_name          = each.value.ssl_profile[ssl_profile.key].ssl_policy.policy_name
          policy_type          = each.value.ssl_profile[ssl_profile.key].ssl_policy.policy_name != null ? each.value.ssl_profile[ssl_profile.key].ssl_policy.disabled_protocols == null ? each.value.ssl_profile[ssl_profile.key].ssl_policy.policy_type : null : null
        }
      }
      trusted_client_certificate_names     = each.value.ssl_profile[ssl_profile.key].trusted_client_certificate_names
      verify_client_cert_issuer_dn         = each.value.ssl_profile[ssl_profile.key].verify_client_cert_issuer_dn
      verify_client_certificate_revocation = each.value.ssl_profile[ssl_profile.key].verify_client_certificate_revocation
    }
  }

  dynamic "trusted_client_certificate" {

    for_each = each.value.trusted_client_certificate != null ? range(length(each.value.trusted_client_certificate)) : []

    content {
      # Required
      data = each.value.trusted_client_certificate[trusted_client_certificate.key].data
      name = each.value.trusted_client_certificate[trusted_client_certificate.key].name

      # Optional
    }
  }

  dynamic "trusted_root_certificate" {

    for_each = each.value.trusted_root_certificate != null ? range(length(each.value.trusted_root_certificate)) : []

    content {
      # Required
      name = each.value.trusted_root_certificate[trusted_root_certificate.key].name

      # Optional
      data                = each.value.trusted_root_certificate[trusted_root_certificate.key].data
      key_vault_secret_id = each.value.trusted_root_certificate[trusted_root_certificate.key].key_vault_secret_id
    }
  }

  dynamic "url_path_map" {

    for_each = each.value.url_path_map != null ? range(length(each.value.url_path_map)) : []

    content {
      # Required
      name = each.value.url_path_map[url_path_map.key].name
      dynamic "path_rule" {
        for_each = each.value.url_path_map[url_path_map.key].path_rule != null ? range(length(each.value.url_path_map[url_path_map.key].path_rule)) : []

        content {
          # Required
          name  = each.value.url_path_map[url_path_map.key].path_rule[path_rule.key].name
          paths = each.value.url_path_map[url_path_map.key].path_rule[path_rule.key].paths
          # Optional
          backend_address_pool_name   = each.value.url_path_map[url_path_map.key].path_rule[path_rule.key].backend_address_pool_name
          backend_http_settings_name  = each.value.url_path_map[url_path_map.key].path_rule[path_rule.key].backend_http_settings_name
          firewall_policy_id          = each.value.url_path_map[url_path_map.key].path_rule[path_rule.key].firewall_policy_id
          redirect_configuration_name = each.value.url_path_map[url_path_map.key].path_rule[path_rule.key].redirect_configuration_name
          rewrite_rule_set_name       = each.value.url_path_map[url_path_map.key].path_rule[path_rule.key].rewrite_rule_set_name
        }
      }

      # Optional
      default_backend_address_pool_name   = each.value.url_path_map[url_path_map.key].default_backend_address_pool_name
      default_backend_http_settings_name  = each.value.url_path_map[url_path_map.key].default_backend_http_settings_name
      default_redirect_configuration_name = each.value.url_path_map[url_path_map.key].default_redirect_configuration_name
      default_rewrite_rule_set_name       = each.value.url_path_map[url_path_map.key].default_rewrite_rule_set_name
    }
  }

  dynamic "waf_configuration" {

    for_each = each.value.waf_configuration != null ? range(length(each.value.waf_configuration)) : []

    content {
      # Required
      enabled          = each.value.waf_configuration[waf_configuration.key].enabled
      firewall_mode    = each.value.waf_configuration[waf_configuration.key].firewall_mode
      rule_set_version = each.value.waf_configuration[waf_configuration.key].rule_set_version

      # Optional
      dynamic "disabled_rule_group" {

        for_each = each.value.waf_configuration[waf_configuration.key].disabled_rule_group != null ? range(length(each.value.waf_configuration[waf_configuration.key].disabled_rule_group)) : []

        content {
          # Required
          rule_group_name = each.value.waf_configuration[waf_configuration.key].disabled_rule_group[disabled_rule_group.key].rule_group_name

          # Optional
          rules = each.value.waf_configuration[waf_configuration.key].disabled_rule_group[disabled_rule_group.key].rules
        }
      }
      dynamic "exclusion" {

        for_each = each.value.waf_configuration[waf_configuration.key].exclusion != null ? range(length(each.value.waf_configuration[waf_configuration.key].exclusion)) : []

        content {
          # Required
          match_variable = each.value.waf_configuration[waf_configuration.key].exclusion[exclusion.key].match_variable

          # Optional
          selector_match_operator = each.value.waf_configuration[waf_configuration.key].exclusion[exclusion.key].selector_match_operator
          selector                = each.value.waf_configuration[waf_configuration.key].exclusion[exclusion.key].selector
        }
      }
      file_upload_limit_mb     = each.value.waf_configuration[waf_configuration.key].file_upload_limit_mb
      max_request_body_size_kb = each.value.waf_configuration[waf_configuration.key].max_request_body_size_kb
      request_body_check       = each.value.waf_configuration[waf_configuration.key].request_body_check
      rule_set_type            = each.value.waf_configuration[waf_configuration.key].rule_set_type
    }
  }


  lifecycle {
    prevent_destroy = false
  }
}
