resource "azurerm_cdn_frontdoor_profile" "main" {
  for_each            = try({ for key, value in var.cdn_frontdoor_data : key => value }, {})
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  sku_name            = each.value.sku_name
  tags                = each.value.tags

  response_timeout_seconds = each.value.response_timeout_seconds
}

resource "azurerm_cdn_frontdoor_endpoint" "main" {
  for_each                 = try({ for key, value in var.cdn_frontdoor_endpoints_data : key => value }, {})
  name                     = each.value.name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.main[each.value.cdn_frontdoor_profile_name].id
  enabled                  = each.value.enabled
  tags                     = each.value.tags
}

resource "azurerm_cdn_frontdoor_custom_domain" "main" {
  for_each                 = try({ for key, value in var.cdn_frontdoor_custom_domains_data : key => value }, {})
  name                     = each.value.name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.main[each.value.cdn_frontdoor_profile_name].id
  dns_zone_id              = each.value.dns_zone_id
  host_name                = each.value.host_name

  dynamic "tls" {
    for_each = each.value.tls != null ? [1] : []
    content {
      certificate_type        = each.value.tls.certificate_type
      minimum_tls_version     = each.value.tls.minimum_tls_version
      cdn_frontdoor_secret_id = each.value.tls.cdn_frontdoor_secret_id
    }
  }
}

resource "azurerm_cdn_frontdoor_route" "main" {
  for_each = try({ for key, value in var.cdn_frontdoor_routes_data : key => value }, {})
  name     = each.value.name
  enabled  = each.value.enabled

  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.main[each.value.endpoint_name].id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.main[each.value.origin_group_name].id

  cdn_frontdoor_origin_ids = local.origins_names_per_route[each.value.name]

  forwarding_protocol = each.value.forwarding_protocol
  patterns_to_match   = each.value.patterns_to_match
  supported_protocols = each.value.supported_protocols

  dynamic "cache" {
    for_each = each.value.cache == null ? [] : ["enabled"]
    content {
      query_string_caching_behavior = each.value.cache.query_string_caching_behavior
      query_strings                 = each.value.cache.query_strings
      compression_enabled           = each.value.cache.compression_enabled
      content_types_to_compress     = each.value.cache.content_types_to_compress
    }
  }

  cdn_frontdoor_custom_domain_ids = try(local.custom_domains_per_route[each.key], [])
  cdn_frontdoor_origin_path       = each.value.origin_path
  cdn_frontdoor_rule_set_ids      = try(local.rule_sets_per_route[each.key], [])

  https_redirect_enabled = each.value.https_redirect_enabled
  link_to_default_domain = each.value.link_to_default_domain
}