# outputs.tf
# Outputs for the Palo Alto Firewall Module

# Resource Group Output
output "resource_group_name" {
  description = "The name of the resource group where the firewall is deployed"
  value       = local.resource_group_name
}

# Firewall Outputs
output "firewall_id" {
  description = "The ID of the deployed firewall"
  value = coalesce(
    one(azurerm_palo_alto_next_generation_firewall_virtual_network_local_rulestack.this[*].id),
    one(azurerm_palo_alto_next_generation_firewall_virtual_network_panorama.this[*].id),
    one(azurerm_palo_alto_next_generation_firewall_virtual_hub_local_rulestack.this[*].id),
    one(azurerm_palo_alto_next_generation_firewall_virtual_hub_panorama.this[*].id)
  )
}

output "firewall_name" {
  description = "The name of the deployed firewall"
  value       = var.name
}

# Rulestack Output
output "local_rulestack_id" {
  description = "The ID of the local rulestack (if created)"
  value       = one(azurerm_palo_alto_local_rulestack.this[*].id)
}

# Virtual Network Appliance Output
output "virtual_network_appliance_id" {
  description = "The ID of the virtual network appliance (if created)"
  value       = one(azurerm_palo_alto_virtual_network_appliance.this[*].id)
}

# Panorama Outputs
output "panorama_details" {
  description = "Panorama details for the deployed firewall (if using Panorama)"
  value = local.create_vnet_panorama ? {
    device_group_name    = one(azurerm_palo_alto_next_generation_firewall_virtual_network_panorama.this[*].panorama.device_group_name)
    host_name            = one(azurerm_palo_alto_next_generation_firewall_virtual_network_panorama.this[*].panorama.host_name)
    panorama_server_1    = one(azurerm_palo_alto_next_generation_firewall_virtual_network_panorama.this[*].panorama.panorama_server_1)
    panorama_server_2    = one(azurerm_palo_alto_next_generation_firewall_virtual_network_panorama.this[*].panorama.panorama_server_2)
    template_name        = one(azurerm_palo_alto_next_generation_firewall_virtual_network_panorama.this[*].panorama.template_name)
  } : null
}