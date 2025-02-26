# local_rulestack_extension.tf
# Optional submodule to create local rulestack resources like rules, FQDN lists, and prefix lists

# Only include this if local rulestack is used
locals {
  local_rulestack_enabled = local.create_vnet_local_rulestack || local.create_vhub_local_rulestack
}

# FQDN Lists
resource "azurerm_palo_alto_local_rulestack_fqdn_list" "this" {
  for_each    = local.local_rulestack_enabled ? var.fqdn_lists : {}
  
  name        = each.key
  rulestack_id = azurerm_palo_alto_local_rulestack.this[0].id
  
  fully_qualified_domain_names = each.value.fqdns
  description                  = each.value.description
  audit_comment                = each.value.audit_comment
}

# Prefix Lists
resource "azurerm_palo_alto_local_rulestack_prefix_list" "this" {
  for_each    = local.local_rulestack_enabled ? var.prefix_lists : {}
  
  name        = each.key
  rulestack_id = azurerm_palo_alto_local_rulestack.this[0].id
  
  prefix_list  = each.value.prefixes
  description  = each.value.description
  audit_comment = each.value.audit_comment
}

# Certificates
resource "azurerm_palo_alto_local_rulestack_certificate" "this" {
  for_each    = local.local_rulestack_enabled ? var.certificates : {}
  
  name        = each.key
  rulestack_id = azurerm_palo_alto_local_rulestack.this[0].id
  
  self_signed            = each.value.self_signed
  key_vault_certificate_id = each.value.key_vault_certificate_id
  description            = each.value.description
  audit_comment          = each.value.audit_comment
}

# Outbound Trust Certificate Association
resource "azurerm_palo_alto_local_rulestack_outbound_trust_certificate_association" "this" {
  count         = local.local_rulestack_enabled && var.outbound_trust_certificate_name != null ? 1 : 0
  
  certificate_id = azurerm_palo_alto_local_rulestack_certificate.this[var.outbound_trust_certificate_name].id
}

# Outbound Untrust Certificate Association
resource "azurerm_palo_alto_local_rulestack_outbound_untrust_certificate_association" "this" {
  count         = local.local_rulestack_enabled && var.outbound_untrust_certificate_name != null ? 1 : 0
  
  certificate_id = azurerm_palo_alto_local_rulestack_certificate.this[var.outbound_untrust_certificate_name].id
}

# Local Rulestack Rules
resource "azurerm_palo_alto_local_rulestack_rule" "this" {
  for_each    = local.local_rulestack_enabled ? var.rules : {}
  
  name        = each.key
  rulestack_id = azurerm_palo_alto_local_rulestack.this[0].id
  priority     = each.value.priority
  action       = each.value.action
  
  applications        = each.value.applications
  protocol            = lookup(each.value, "protocol", "application-default")
  protocol_ports      = lookup(each.value, "protocol_ports", null)
  description         = lookup(each.value, "description", null)
  enabled             = lookup(each.value, "enabled", true)
  audit_comment       = lookup(each.value, "audit_comment", null)
  logging_enabled     = lookup(each.value, "logging_enabled", false)
  negate_source       = lookup(each.value, "negate_source", false)
  negate_destination  = lookup(each.value, "negate_destination", false)
  decryption_rule_type = lookup(each.value, "decryption_rule_type", null)
  inspection_certificate_id = lookup(each.value, "inspection_certificate_id", null)
  
  # Source configuration
  dynamic "source" {
    for_each = [each.value.source]
    content {
      cidrs                          = lookup(source.value, "cidrs", [])
      countries                      = lookup(source.value, "countries", [])
      feeds                          = lookup(source.value, "feeds", [])
      local_rulestack_prefix_list_ids = lookup(source.value, "local_rulestack_prefix_list_ids", [])
    }
  }
  
  # Destination configuration
  dynamic "destination" {
    for_each = [each.value.destination]
    content {
      cidrs                          = lookup(destination.value, "cidrs", [])
      countries                      = lookup(destination.value, "countries", [])
      feeds                          = lookup(destination.value, "feeds", [])
      local_rulestack_prefix_list_ids = lookup(destination.value, "local_rulestack_prefix_list_ids", [])
      local_rulestack_fqdn_list_ids   = lookup(destination.value, "local_rulestack_fqdn_list_ids", [])
    }
  }
  
  # Category configuration if specified
  dynamic "category" {
    for_each = lookup(each.value, "category", null) != null ? [each.value.category] : []
    content {
      feeds       = lookup(category.value, "feeds", [])
      custom_urls = lookup(category.value, "custom_urls", [])
    }
  }
}