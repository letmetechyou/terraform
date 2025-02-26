# extension_outputs.tf
# Outputs for the Local Rulestack Extension

# FQDN Lists
output "fqdn_list_ids" {
  description = "Map of created FQDN list names to their IDs"
  value = { for k, v in azurerm_palo_alto_local_rulestack_fqdn_list.this : k => v.id }
}

# Prefix Lists
output "prefix_list_ids" {
  description = "Map of created prefix list names to their IDs"
  value = { for k, v in azurerm_palo_alto_local_rulestack_prefix_list.this : k => v.id }
}

# Certificates
output "certificate_ids" {
  description = "Map of created certificate names to their IDs"
  value = { for k, v in azurerm_palo_alto_local_rulestack_certificate.this : k => v.id }
}

# Outbound Trust Certificate Association
output "outbound_trust_certificate_association_id" {
  description = "ID of the outbound trust certificate association if created"
  value = one(azurerm_palo_alto_local_rulestack_outbound_trust_certificate_association.this[*].id)
}

# Outbound Untrust Certificate Association
output "outbound_untrust_certificate_association_id" {
  description = "ID of the outbound untrust certificate association if created"
  value = one(azurerm_palo_alto_local_rulestack_outbound_untrust_certificate_association.this[*].id)
}

# Rules
output "rule_ids" {
  description = "Map of created rule names to their IDs"
  value = { for k, v in azurerm_palo_alto_local_rulestack_rule.this : k => v.id }
}