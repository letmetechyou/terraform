module "api_management" {
  source = "./Modules/hashicorp/azurerm/api_management"

  api_management_data = module._defaults.merge["api_management"]
  public_ip_output    = module.public_ip.public_ip_output_names
}

module "api_management_v2" {
  source = "./Modules/hashicorp/azurerm/api_management_v2"

  api_management_data_v2 = module._defaults.merge["api_management_v2"]
  public_ip_output       = module.public_ip.public_ip_output_names
  subnet_output          = module.subnet.subnet_output_names
  key_vault_output       = module.key_vault.key_vault_output_names
  resource_group_output  = module.resource_group.resource_group_output_names
}

module "application_gateway" {
  source = "./Modules/hashicorp/azurerm/application_gateway"

  application_gateway_data = module._defaults.merge["application_gateway"]
}

module "application_insights" {

  source                    = "./Modules/hashicorp/azurerm/application_insights"
  application_insights_data = var.application_insights_data

}

module "availability_set" {
  source = "./Modules/hashicorp/azurerm/availability_set"

  availability_set_data = module._defaults.merge["availability_set"]
  resource_group_output = module.resource_group.resource_group_output_names
}

module "azurerm_linux_virtual_machine" {
  source = "./Modules/hashicorp/azurerm/azurerm_linux_virtual_machine"

  linux_virtual_machine_data    = module._defaults.merge["azurerm_linux_virtual_machine"]
  tls_private_key_output        = module.tls_private_key.tls_private_key_output
  network_security_group_output = module.network_security_group.network_security_group_output
  resource_group_output         = module.resource_group.resource_group_output_names
  key_vault_output              = module.key_vault.key_vault_output_names
}

module "backup_policy_vm" {
  source = "./Modules/hashicorp/azurerm/backup_policy_vm"

  backup_policy_vm_data = module._defaults.merge["backup_policy_vm"]
}

module "cdn_front_door_data" {
  source                               = "./Modules/hashicorp/azurerm/cdn_frontdoor"
  cdn_frontdoor_data                   = var.cdn_frontdoor_data
  cdn_frontdoor_endpoints_data         = var.cdn_frontdoor_endpoints_data
  cdn_frontdoor_origin_groups_data     = var.cdn_frontdoor_origin_groups_data
  cdn_frontdoor_origins_data           = var.cdn_frontdoor_origins_data
  cdn_frontdoor_custom_domains_data    = var.cdn_frontdoor_custom_domains_data
  cdn_frontdoor_routes_data            = var.cdn_frontdoor_routes_data
  cdn_frontdoor_rule_sets_data         = var.cdn_frontdoor_rule_sets_data
  cdn_frontdoor_firewall_policies_data = var.cdn_frontdoor_firewall_policies_data
  cdn_frontdoor_security_policies_data = var.cdn_frontdoor_security_policies_data
}
module "container_registry" {
  source                    = "./Modules/hashicorp/azurerm/container_registry"
  container_registry_data = var.container_registry_data
}

module "data_protection_backup_vault" {
  source = "./Modules/hashicorp/azurerm/data_protection_backup_vault"

  data_protection_backup_vault_data = module._defaults.merge["data_protection_backup_vault"]
}

module "eventhub" {
  source = "./Modules/hashicorp/azurerm/eventhub"

  eventhub_data = module._defaults.merge["eventhub"]
}

import {
  for_each = { for key, value in var.express_route_circuit_data : key => value if value.import }
  id       = each.value.import_resource_id
  to       = module.express_route_circuit_data.azurerm_express_route_circuit.express_route_circuit[each.key]
}

module "express_route_circuit_data" {
  source                     = "./Modules/hashicorp/azurerm/express_route_circuit"
  express_route_circuit_data = var.express_route_circuit_data
}

import {
  for_each = { for key, value in var.express_route_circuit_peering_data : key => value if value.import }
  id       = each.value.import_resource_id
  to       = module.express_route_circuit_peering_data.azurerm_express_route_circuit_peering.express_route_circuit_peering[each.key]
}

module "express_route_circuit_peering_data" {
  source                             = "./Modules/hashicorp/azurerm/express_route_circuit_peering"
  express_route_circuit_peering_data = var.express_route_circuit_peering_data
}

import {
  for_each = { for key, value in var.express_route_circuit_authorization_data : key => value if value.import }
  id       = each.value.import_resource_id
  to       = module.express_route_circuit_authorization.azurerm_express_route_circuit_authorization.express_route_circuit_authorization[each.key]
}

module "express_route_circuit_authorization" {
  source = "./Modules/hashicorp/azurerm/express_route_circuit_authorization"

  express_route_circuit_authorization_data = module._defaults.merge["express_route_circuit_authorization"]
}

import {
  for_each = { for key, value in var.express_route_connection_data : key => value if value.import }
  id       = each.value.import_resource_id
  to       = module.express_route_connection.azurerm_express_route_connection.express_route_connection[each.key]
}

module "express_route_connection" {
  source = "./Modules/hashicorp/azurerm/express_route_connection"

  express_route_connection_data = module._defaults.merge["express_route_connection"]
}

module "firewall" {
  source = "./Modules/hashicorp/azurerm/firewall"

  firewall_data          = module._defaults.merge["firewall"]
  subnet_output          = module.subnet.subnet_output_names
  public_ip_output       = module.public_ip.public_ip_output_names
  firewall_policy_output = module.firewall_policy.firewall_policy_output_names
  resource_group_output  = module.resource_group.resource_group_output_names
}

module "firewall_policy" {
  source = "./Modules/hashicorp/azurerm/firewall_policy"

  firewall_policy_data = module._defaults.merge["firewall_policy"]
  resource_group_output = module.resource_group.resource_group_output_names
}

module "firewall_rule_collection_group" {
  source = "./Modules/hashicorp/azurerm/firewall_policy_rule_collection_group"

  firewall_policy_rule_collection_group_data = module._defaults.merge["firewall_policy_rule_collection_group"]
  firewall_policy_output                     = module.firewall_policy.firewall_policy_output_names

}

import {
  for_each = { for key, value in var.key_vault_data : key => value if value.import }
  id       = each.value.import_resource_id
  to       = module.key_vault.azurerm_key_vault.main[each.key]
}

module "key_vault" {
  source = "./Modules/hashicorp/azurerm/key_vault"

  key_vault_data        = module._defaults.merge["key_vault"]
  resource_group_output = module.resource_group.resource_group_output_names
}

import {
  for_each = { for key, value in var.key_vault_access_policy_data : key => value if value.import }
  id       = each.value.import_resource_id
  to       = module.key_vault_access_policy.azurerm_key_vault_access_policy.main[each.key]
}

module "key_vault_access_policy" {
  source = "./Modules/hashicorp/azurerm/key_vault_access_policy"

  key_vault_access_policy_data  = module._defaults.merge["key_vault_access_policy"]
  user_assigned_identity_output = module.user_assigned_identity.user_assigned_identity_output_names
  key_vault_output              = module.key_vault.key_vault_output_names
  #depends_on     = [module.user_assigned_identity]
}

module "key_vault_certificate" {
  source = "./Modules/hashicorp/azurerm/key_vault_certificate"

  key_vault_certificate_data = module._defaults.merge["key_vault_certificate"]
  key_vault_output           = module.key_vault.key_vault_output_names
}

import {
  for_each = { for key, value in var.key_vault_key_data : key => value if value.import }
  id       = each.value.import_resource_id
  to       = module.key_vault_key.azurerm_key_vault_key.key_vault_key[each.key]
}

module "key_vault_key" {
  source = "./Modules/hashicorp/azurerm/key_vault_key"

  key_vault_key_data = module._defaults.merge["key_vault_key"]
  key_vault_output   = module.key_vault.key_vault_output_names
  depends_on         = [module.key_vault, module.private_endpoint, module.key_vault_managed_hardware_security_module]

}

module "key_vault_managed_hardware_security_module" {
  source = "./Modules/hashicorp/azurerm/key_vault_managed_hardware_security_module"

  key_vault_managed_hardware_security_module_data = module._defaults.merge["key_vault_managed_hardware_security_module"]
}

module "key_vault_managed_hardware_security_module_role_assignment" {
  source = "./Modules/hashicorp/azurerm/key_vault_managed_hardware_security_module_role_assignment"

  key_vault_managed_hardware_security_module_role_assignment_data = module._defaults.merge["key_vault_managed_hardware_security_module_role_assignment"]
}

module "key_vault_secret" {
  source = "./Modules/hashicorp/azurerm/key_vault_secret"

  key_vault_secret_data  = module._defaults.merge["key_vault_secret"]
  tls_private_key_output = module.tls_private_key.tls_private_key_output

  depends_on = [module.key_vault, module.key_vault_managed_hardware_security_module]
}

module "lb" {
  source = "./Modules/hashicorp/azurerm/lb"

  lb_data                           = module._defaults.merge["lb"]
  lb_frontend_ip_configuration_data = module._defaults.merge["lb_frontend_ip_configuration"]
  subnet_output                     = module.subnet.subnet_output_names
}

module "lb_backend_address_pool" {
  source = "./Modules/hashicorp/azurerm/lb_backend_address_pool"

  lb_backend_address_pool_data = module._defaults.merge["lb_backend_address_pool"]
  lb_output                    = module.lb.lb_output_names
}

module "lb_backend_address_pool_address" {
  source = "./Modules/hashicorp/azurerm/lb_backend_address_pool_address"

  lb_backend_address_pool_address_data = module._defaults.merge["lb_backend_address_pool_address"]
}

module "lb_probe" {
  source = "./Modules/hashicorp/azurerm/lb_probe"

  lb_probe_data = module._defaults.merge["lb_probe"]
  lb_output     = module.lb.lb_output_names
}

module "lb_rule" {
  source = "./Modules/hashicorp/azurerm/lb_rule"

  lb_rule_data                   = module._defaults.merge["lb_rule"]
  lb_output                      = module.lb.lb_output_names
  lb_backend_address_pool_output = module.lb_backend_address_pool.lb_backend_address_pool_output_names
  lb_probe_output                = module.lb_probe.lb_probe_output_names
}

module "lb_outbound_rule" {
  source = "./Modules/hashicorp/azurerm/lb_outbound_rule"

  lb_outbound_rule_data          = var.lb_outbound_rule_data
  lb_output                      = module.lb.lb_output_names
  lb_backend_address_pool_output = module.lb_backend_address_pool.lb_backend_address_pool_output_names
  lb_probe_output                = module.lb_probe.lb_probe_output_names
}

module "linux_virtual_machine" {
  source = "./Modules/hashicorp/azurerm/linux_virtual_machines"

  linux_virtual_machine_data = module._defaults.merge["linux_virtual_machine"]
}

module "local_network_gateway" {
  source = "./Modules/hashicorp/azurerm/local_network_gateway"

  local_network_gateway_data = module._defaults.merge["local_network_gateway"]
}

module "log_analytics_workspace" {
  source = "./Modules/hashicorp/azurerm/log_analytics_workspace"

  log_analytics_workspace_data = module._defaults.merge["log_analytics_workspace"]
  resource_group_output = module.resource_group.resource_group_output_names
}

module "managed_disk" {
  source = "./Modules/hashicorp/azurerm/managed_disk"

  managed_disk_data = module._defaults.merge["managed_disk"]
}

module "management_lock" {
  source = "./Modules/hashicorp/azurerm/management_lock"

  management_lock_data = module._defaults.merge["management_lock"]
}

module "marketplace_agreement" {
  source = "./Modules/hashicorp/azurerm/marketplace_agreement"

  marketplace_agreement_data = module._defaults.merge["marketplace_agreement"]
}

module "monitor_activity_log_alert" {
  source = "./Modules/hashicorp/azurerm/monitor_activity_log_alert"

  monitor_activity_log_alert_data = module._defaults.merge["monitor_activity_log_alert"]
  resource_group_output           = module.resource_group.resource_group_output_names
}

module "monitor_diagnostic_setting" {
  source = "./Modules/hashicorp/azurerm/monitor_diagnostic_setting"

  monitor_diagnostic_setting_data = module._defaults.merge["monitor_diagnostic_setting"]
}

module "mssql_firewall_rule" {
  source = "./Modules/hashicorp/azurerm/mssql_firewall_rule"

  mssql_firewall_rule_data = module._defaults.merge["mssql_firewall_rule"]
  mssql_server_output      = module.mssql_server.mssql_server_output_names
}

module "mssql_server" {
  source = "./Modules/hashicorp/azurerm/mssql_server"

  mssql_server_data = module._defaults.merge["mssql_server"]
}

module "mssql_server_extended_auditing_policy" {
  source = "./Modules/hashicorp/azurerm/mssql_server_extended_auditing_policy"

  mssql_server_extended_auditing_policy_data = module._defaults.merge["mssql_server_extended_auditing_policy"]
  mssql_server_output                        = module.mssql_server.mssql_server_output_names
}

module "mssql_server_security_alert_policy" {
  source = "./Modules/hashicorp/azurerm/mssql_server_security_alert_policy"

  mssql_server_security_alert_policy_data = module._defaults.merge["mssql_server_security_alert_policy"]
  mssql_server_output                     = module.mssql_server.mssql_server_output_names
  storage_account_output                  = module.storage_account.storage_account_output_names
  depends_on                              = [module.storage_account]
}

module "mssql_virtual_network_rule" {
  source = "./Modules/hashicorp/azurerm/mssql_virtual_network_rule"

  mssql_virtual_network_rule_data = module._defaults.merge["mssql_virtual_network_rule"]
  mssql_server_output             = module.mssql_server.mssql_server_output_names

}

import {
  for_each = { for key, value in var.nat_gateway_data : key => value if value.import }
  id       = each.value.import_resource_id
  to       = module.nat_gateway.azurerm_nat_gateway.nat_gateway[each.key]
}

module "nat_gateway" {
  source = "./Modules/hashicorp/azurerm/nat_gateway"

  nat_gateway_data = module._defaults.merge["nat_gateway"]
}

import {
  for_each = { for key, value in var.nat_gateway_public_ip_association_data : key => value if value.import }
  id       = each.value.import_resource_id
  to       = module.nat_gateway_public_ip_association.azurerm_nat_gateway_public_ip_association.nat_gateway_public_ip_association[each.key]
}

module "nat_gateway_public_ip_association" {
  source = "./Modules/hashicorp/azurerm/nat_gateway_public_ip_association"

  nat_gateway_public_ip_association_data = var.nat_gateway_public_ip_association_data
  public_ip_output                       = module.public_ip.public_ip_output_names
  nat_gateway_output                     = module.nat_gateway.nat_gateway_output_names
}

import {
  for_each = { for key, value in var.nat_gateway_public_ip_prefix_association_data : key => value if value.import }
  id       = each.value.import_resource_id
  to       = module.nat_gateway_public_ip_prefix_association.azurerm_nat_gateway_public_ip_prefix_association.nat_gateway_public_ip_prefix_association[each.key]
}


module "nat_gateway_public_ip_prefix_association" {
  source = "./Modules/hashicorp/azurerm/nat_gateway_public_ip_prefix_association"

  nat_gateway_public_ip_prefix_association_data = module._defaults.merge["nat_gateway_public_ip_prefix_association"]
  public_ip_prefix_output                       = module.public_ip_prefix.public_ip_prefix_output_names
  nat_gateway_output                            = module.nat_gateway.nat_gateway_output_names
}

module "network_interface" {
  source = "./Modules/hashicorp/azurerm/network_interface"

  network_interface_data = module._defaults.merge["network_interface"]
  resource_group_output  = module.resource_group.resource_group_output_names
  subnet_output          = module.subnet.subnet_output_names
}

module "network_interface_backend_address_pool_association" {
  source = "./Modules/hashicorp/azurerm/network_interface_backend_address_pool_association"

  network_interface_backend_address_pool_association_data = module._defaults.merge["network_interface_backend_address_pool_association"]
  network_interface_output                                = module.palo_alto.network_interface_output_names
  lb_backend_address_pool_output                          = module.lb_backend_address_pool.lb_backend_address_pool_output_names
}

module "network_interface_security_group_association" {
  source = "./Modules/hashicorp/azurerm/network_interface_security_group_association"

  network_interface_security_group_association_data = module._defaults.merge["network_interface_security_group_association"]
  network_interface_output                          = module.network_interface.network_interface_output_names
  network_security_group_output                     = module.network_security_group.network_security_group_output_names
}

import {
  for_each = { for key, value in var.network_security_group_data : key => value if value.import }
  id       = each.value.import_resource_id
  to       = module.network_security_group.azurerm_network_security_group.network_security_group[each.key]
}

module "network_security_group" {
  source = "./Modules/hashicorp/azurerm/network_security_group"

  network_security_group_data = module._defaults.merge["network_security_group"]
  resource_group_output = module.resource_group.resource_group_output_names
}

module "network_security_rule" {
  source = "./Modules/hashicorp/azurerm/network_security_rule"

  network_security_rule_data    = module._defaults.merge["network_security_rule"]
  network_security_group_output = module.network_security_group.network_security_group_output_names
}

module "network_watcher_flow_log" {
  source = "./Modules/hashicorp/azurerm/network_watcher_flow_log"

  network_watcher_flow_log_data = module._defaults.merge["network_watcher_flow_log"]
  network_security_group_output = module.network_security_group.network_security_group_output_names
  storage_acccount_output       = module.storage_account.storage_account_output_names
}

module "palo_alto" {
  source = "./Modules/hashicorp/azurerm/palo_alto"

  fw_data                 = module._defaults.merge["palo_alto"]
  availability_set_output = module.availability_set.availability_set_output
  #public_ip_prefix_output = data.terraform_remote_state.remote_state.outputs.public_ip_prefix.public_ip_prefix_output
  subnet_output         = module.subnet.subnet_output_names
  ssh_public_key_output = module.ssh_public_key.ssh_public_key_output_names
  depends_on            = [module.marketplace_agreement]
}

module "palo_alto_virtual_machine_data_disk_attachment" {
  source = "./Modules/hashicorp/azurerm/virtual_machine_data_disk_attachment"

  virtual_machine_data_disk_attachment_data = module._defaults.merge["palo_alto_virtual_machine_data_disk_attachment"]
  managed_disk_output                       = module.managed_disk.managed_disk_output_names
  virtual_machine_output                    = module.palo_alto.virtual_machine_output
}

module "private_dns_resolver" {
  source = "./Modules/hashicorp/azurerm/private_dns_resolver"

  private_dns_resolver_data = module._defaults.merge["private_dns_resolver"]
  virtual_network_output    = module.virtual_network.virtual_network_output_names
}

module "private_dns_resolver_dns_forwarding_ruleset" {
  source = "./Modules/hashicorp/azurerm/private_dns_resolver_dns_forwarding_ruleset"

  private_dns_resolver_dns_forwarding_ruleset_data = module._defaults.merge["private_dns_resolver_dns_forwarding_ruleset"]
  private_dns_resolver_outbound_endpoint_output    = module.private_dns_resolver_outbound_endpoint.private_dns_resolver_outbound_endpoint_output_names
}

module "private_dns_resolver_forwarding_rule" {
  source = "./Modules/hashicorp/azurerm/private_dns_resolver_forwarding_rule"

  private_dns_resolver_forwarding_rule_data         = module._defaults.merge["private_dns_resolver_forwarding_rule"]
  private_dns_resolver_dns_forwarding_ruleset_ouput = module.private_dns_resolver_dns_forwarding_ruleset.private_dns_resolver_dns_forwarding_ruleset_output_names
}

module "private_dns_resolver_inbound_endpoint" {
  source = "./Modules/hashicorp/azurerm/private_dns_resolver_inbound_endpoint"

  private_dns_resolver_inbound_endpoint_data = var.private_dns_resolver_inbound_endpoint_data
}


module "private_dns_resolver_outbound_endpoint" {
  source = "./Modules/hashicorp/azurerm/private_dns_resolver_outbound_endpoint"

  private_dns_resolver_outbound_endpoint_data = module._defaults.merge["private_dns_resolver_outbound_endpoint"]
  private_dns_resolver_output                 = module.private_dns_resolver.private_dns_resolver_output_names
  subnet_output                               = module.subnet.subnet_output_names
}

module "private_dns_resolver_virtual_network_link" {
  source = "./Modules/hashicorp/azurerm/private_dns_resolver_virtual_network_link"

  private_dns_resolver_virtual_network_link_data     = module._defaults.merge["private_dns_resolver_virtual_network_link"]
  virtual_network_output                             = module.virtual_network.virtual_network_output_names
  private_dns_resolver_dns_forwarding_ruleset_output = module.private_dns_resolver_dns_forwarding_ruleset.private_dns_resolver_dns_forwarding_ruleset_output_names
}

import {
  for_each = { for key, value in var.private_endpoint_data : key => value if value.import }
  id       = each.value.import_resource_id
  to       = module.private_endpoint.azurerm_private_endpoint.private_endpoint[each.key]
}

module "private_endpoint" {
  source = "./Modules/hashicorp/azurerm/private_endpoint"

  private_endpoint_data                             = module._defaults.merge["private_endpoint"]
  mssql_server_output                               = module.mssql_server.mssql_server_output_names
  storage_account_output                            = module.storage_account.storage_account_output_names
  key_vault_output                                  = module.key_vault.key_vault_output_names
  key_vault_managed_hardware_security_module_output = module.key_vault_managed_hardware_security_module.key_vault_managed_hardware_security_module_output_names
  recovery_services_vault_output                    = module.recovery_services_vault.recovery_services_vault_output_names
  subnet_output                                     = module.subnet.subnet_output_names
  depends_on                                        = [module.key_vault, module.key_vault_managed_hardware_security_module]
}

import {
  for_each = { for key, value in var.public_ip_data : key => value if value.import }
  id       = each.value.import_resource_id
  to       = module.public_ip.azurerm_public_ip.public_ip[each.key]
}

module "public_ip" {
  source = "./Modules/hashicorp/azurerm/public_ip"

  public_ip_data = module._defaults.merge["public_ip"]
  resource_group_output = module.resource_group.resource_group_output_names
}

import {
  for_each = { for key, value in var.public_ip_prefix_data : key => value if value.import }
  id       = each.value.import_resource_id
  to       = module.public_ip_prefix.azurerm_public_ip_prefix.public_ip_prefix[each.key]
}

module "public_ip_prefix" {
  source = "./Modules/hashicorp/azurerm/public_ip_prefix"

  public_ip_prefix_data = module._defaults.merge["public_ip_prefix"]
}

module "recovery_services_vault" {
  source = "./Modules/hashicorp/azurerm/recovery_services_vault"

  recovery_services_vault_data = module._defaults.merge["recovery_services_vault"]
  depends_on                   = [module.resource_group]
}

import {
  for_each = { for key, value in var.resource_group_data : key => value if value.import }
  id       = each.value.import_resource_id
  to       = module.resource_group.azurerm_resource_group.resource_group[each.key]
}

module "resource_group" {
  source = "./Modules/hashicorp/azurerm/resource_group"

  resource_group_data = module._defaults.merge["resource_group"]
}

module "role_assignment" {
  source = "./Modules/hashicorp/azurerm/role_assignment"

  role_assignment_data = module._defaults.merge["role_assignment"]
}

import {
  for_each = { for key, value in var.route_table_data : key => value if value.import }
  id       = each.value.import_resource_id
  to       = module.route_table.azurerm_route_table.main[each.key]
}

module "route_table" {
  source = "./Modules/hashicorp/azurerm/route_table"

  route_table_data      = module._defaults.merge["route_table"]
  resource_group_output = module.resource_group.resource_group_output_names
}

module "security_center_contact" {
  source                       = "./Modules/hashicorp/azurerm/security_center_contact"
  security_center_contact_data = var.security_center_contact_data
}

module "ssh_public_key" {
  source = "./Modules/hashicorp/azurerm/ssh_public_key"

  ssh_public_key_data = module._defaults.merge["ssh_public_key"]
}

module "storage_account" {
  source = "./Modules/hashicorp/azurerm/storage_account"

  storage_account_data = module._defaults.merge["storage_account"]
  resource_group_output = module.resource_group.resource_group_output_names
}

module "storage_container" {
  source = "./Modules/hashicorp/azurerm/storage_container"

  storage_container_data = module._defaults.merge["storage_container"]
  depends_on             = [module.storage_account]

}

module "storage_share" {
  source = "./Modules/hashicorp/azurerm/storage_share"

  storage_share_data = module._defaults.merge["storage_share"]
}

module "storage_share_directory" {
  source = "./Modules/hashicorp/azurerm/storage_share_directory"

  storage_share_directory_data = module._defaults.merge["storage_share_directory"]
}

import {
  for_each = { for key, value in var.subnet_data : key => value if value.import }
  id       = each.value.import_resource_id
  to       = module.subnet.azurerm_subnet.subnet[each.key]
}
module "subnet" {
  source = "./Modules/hashicorp/azurerm/subnet"

  subnet_data            = module._defaults.merge["subnet"]
  resource_group_output  = module.resource_group.resource_group_output_names
  virtual_network_output = module.virtual_network.virtual_network_output_names
}

module "subnet_nat_gateway_association" {
  source = "./Modules/hashicorp/azurerm/subnet_nat_gateway_association"

  subnet_nat_gateway_association_data = module._defaults.merge["subnet_nat_gateway_association"]
  subnet_output                       = module.subnet.subnet_output_names
  nat_gateway_output                  = module.nat_gateway.nat_gateway_output_names
}

import {
  for_each = { for key, value in var.subnet_network_security_group_association_data : key => value if value.import }
  id       = each.value.import_resource_id
  to       = module.subnet_network_security_group_association.azurerm_subnet_network_security_group_association.subnet_network_security_group_association[each.key]
}

module "subnet_network_security_group_association" {
  source = "./Modules/hashicorp/azurerm/subnet_network_security_group_association"

  subnet_network_security_group_association_data = module._defaults.merge["subnet_network_security_group_association"]
  network_security_group_output                  = module.network_security_group.network_security_group_output_names
  subnet_output                                  = module.subnet.subnet_output_names
  depends_on                                     = [module.resource_group]

}

import {
  for_each = { for key, value in var.subnet_route_table_association_data : key => value if value.import }
  id       = each.value.import_resource_id
  to       = module.subnet_route_table_association_data.azurerm_subnet_route_table_association.main[each.key]
}

module "subnet_route_table_association_data" {
  source = "./Modules/hashicorp/azurerm/subnet_route_table_association"

  subnet_route_table_association_data = module._defaults.merge["subnet_route_table_association"]
  subnet_output                       = module.subnet.subnet_output_names
  route_table_output                  = module.route_table.route_table_output_names
}

module "tls_private_key" {
  source = "./Modules/hashicorp/azurerm/private_key"

  tls_private_key_data = var.tls_private_key_data
}

import {
  for_each = { for key, value in var.user_assigned_identity_data : key => value if value.import }
  id       = each.value.import_resource_id
  to       = module.user_assigned_identity.azurerm_user_assigned_identity.main[each.key]
}

module "user_assigned_identity" {
  source = "./Modules/hashicorp/azurerm/user_assigned_identity"

  user_assigned_identity_data = module._defaults.merge["user_assigned_identity"]
}

module "virtual_machine_extension" {
  source = "./Modules/hashicorp/azurerm/virtual_machine_extension"

  virtual_machine_extension_data = module._defaults.merge["virtual_machine_extension"]
  virtual_machine_output         = module.linux_virtual_machine.linux_virtual_machine_output_names

}

import {
  for_each = { for key, value in var.virtual_network_data : key => value if value.import }
  id       = each.value.import_resource_id
  to       = module.virtual_network.azurerm_virtual_network.virtual_network[each.key]
}

output "virtual_network_value" {
  value = module.virtual_network
}

module "virtual_network" {
  source = "./Modules/hashicorp/azurerm/virtual_network"

  virtual_network_data  = module._defaults.merge["virtual_network"]
  resource_group_output = module.resource_group.resource_group_output_names
}

import {
  for_each = { for key, value in var.virtual_network_gateway_data : key => value if value.import }
  id       = each.value.import_resource_id
  to       = module.virtual_network_gateway.azurerm_virtual_network_gateway.virtual_network_gateway[each.key]
}

module "virtual_network_gateway" {
  source = "./Modules/hashicorp/azurerm/virtual_network_gateway"

  virtual_network_gateway_data = module._defaults.merge["virtual_network_gateway"]
  public_ip_output             = module.public_ip.public_ip_output_names
  subnet_output                = module.subnet.subnet_output_names
}

import {
  for_each = { for key, value in var.virtual_network_gateway_connection_data : key => value if value.import }
  id       = each.value.import_resource_id
  to       = module.virtual_network_gateway_connection.azurerm_virtual_network_gateway_connection.virtual_network_gateway_connection[each.key]
}

module "virtual_network_gateway_connection" {
  source = "./Modules/hashicorp/azurerm/virtual_network_gateway_connection"
  providers = {
    azurerm                = azurerm
  }
  virtual_network_gateway_connection_data    = module._defaults.merge["virtual_network_gateway_connection"]
  express_route_circuit_authorization_output = module.express_route_circuit_authorization.express_route_circuit_authorization_output_names
  express_route_circuit_authorization_data   = try(var.vngw_remote_express_route_circuit_authorization_data, {})
}

module "virtual_network_gateway_nat_rule" {
  source = "./Modules/hashicorp/azurerm/virtual_network_gateway_nat_rule"

  virtual_network_gateway_nat_rule_data = var.virtual_network_gateway_nat_rule_data
}

import {
  for_each = { for key, value in var.virtual_network_peering_data : key => value if value.import }
  id       = each.value.import_resource_id
  to       = module.virtual_network_peering.azurerm_virtual_network_peering.virtual_network_peering[each.key]
}


module "virtual_network_peering" {
  source = "./Modules/hashicorp/azurerm/virtual_network_peering"

  virtual_network_peering_data = module._defaults.merge["virtual_network_peering"]
  resource_group_output        = module.resource_group.resource_group_output_names
}

module "windows_virtual_machine" {
  source = "./Modules/hashicorp/azurerm/windows_virtual_machines"

  windows_virtual_machine_data = module._defaults.merge["windows_virtual_machine"]
  resource_group_output        = module.resource_group.resource_group_output_names

}
module "mssql_database" {
  source = "./Modules/hashicorp/azurerm/mssql_database"

  mssql_database_data = module._defaults.merge["mssql_database"]

}