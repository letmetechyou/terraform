resource "azurerm_private_dns_resolver_forwarding_rule" "private_dns_resolver_forwarding_rule" {
  for_each = { for key, value in var.private_dns_resolver_forwarding_rule_data : key => value if value.enabled }

  # Required Arguments
  name        = each.value.name
  domain_name = each.value.domain_name
  dns_forwarding_ruleset_id = coalesce(
    try(each.value.dns_forwarding_ruleset_id, null),
    try(var.private_dns_resolver_dns_forwarding_ruleset_ouput["${each.value.dns_forwarding_ruleset_name}"].id, null),
    try(var.private_dns_resolver_dns_forwarding_ruleset_ouput["${each.value.dns_forwarding_ruleset_key}"].id, null)
  )


  # Required Blocks 

  dynamic "target_dns_servers" {
    for_each = each.value.target_dns_servers != null ? range(length(each.value.target_dns_servers)) : []

    content {
      # Required
      ip_address = each.value.target_dns_servers[target_dns_servers.key].ip_address
      # Optional
      port = each.value.target_dns_servers[target_dns_servers.key].port
    }

  }

  # Optional Arguments
  enabled  = each.value.enabled
  metadata = each.value.metadata


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
