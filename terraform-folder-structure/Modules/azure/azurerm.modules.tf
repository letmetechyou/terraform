module "api_management" {
  source = "./modules/hashicorp/azurerm/api_management"

  api_management_data = module._defaults.merge["api_management"]
  public_ip_output    = module.public_ip.public_ip_output_names
}

module "api_management_v2" {
  source = "./modules/hashicorp/azurerm/api_management_v2"

  api_management_data_v2 = module._defaults.merge["api_management_v2"]
  public_ip_output       = module.public_ip.public_ip_output_names
  subnet_output          = module.subnet.subnet_output_names
  key_vault_output       = module.key_vault.key_vault_output_names
  resource_group_output  = module.resource_group.resource_group_output_names
}

module "application_gateway" {
  source = "./modules/hashicorp/azurerm/application_gateway"

  application_gateway_data = module._defaults.merge["application_gateway"]
}

module "application_insights" {

  source                    = "./modules/hashicorp/azurerm/application_insights"
  application_insights_data = var.application_insights_data

}

module "availability_set" {
  source = "./modules/hashicorp/azurerm/availability_set"

  availability_set_data = module._defaults.merge["availability_set"]
  resource_group_output = module.resource_group.resource_group_output_names
}

module "azurerm_linux_virtual_machine" {
  source = "./modules/hashicorp/azurerm/hashicorp/azurerm_linux_virtual_machine"

  linux_virtual_machine_data    = module._defaults.merge["azurerm_linux_virtual_machine"]
  tls_private_key_output        = module.tls_private_key.tls_private_key_output
  network_security_group_output = module.network_security_group.network_security_group_output
  resource_group_output         = module.resource_group.resource_group_output_names
  key_vault_output              = module.key_vault.key_vault_output_names
}

module "backup_policy_vm" {
  source = "./modules/hashicorp/azurerm/backup_policy_vm"

  backup_policy_vm_data = module._defaults.merge["backup_policy_vm"]
}

module "data_protection_backup_vault" {
  source = "./modules/hashicorp/azurerm/data_protection_backup_vault"

  data_protection_backup_vault_data = module._defaults.merge["data_protection_backup_vault"]
}

module "eventhub" {
  source = "./modules/hashicorp/azurerm/eventhub"

  eventhub_data = module._defaults.merge["eventhub"]
}

module "express_route_circuit_authorization" {
  source = "./modules/hashicorp/azurerm/express_route_circuit_authorization"

  express_route_circuit_authorization_data = module._defaults.merge["express_route_circuit_authorization"]
}

module "express_route_connection" {
  source = "./modules/hashicorp/azurerm/express_route_connection"

  express_route_connection_data = module._defaults.merge["express_route_connection"]
}

module "firewall" {
  source = "./modules/hashicorp/azurerm/firewall"

  firewall_data          = module._defaults.merge["firewall"]
  subnet_output          = module.subnet.subnet_output_names
  public_ip_output       = module.public_ip.public_ip_output_names
  firewall_policy_output = module.firewall_policy.firewall_policy_output_names
}

module "firewall_policy" {
  source = "./modules/hashicorp/azurerm/firewall_policy"

  firewall_policy_data = module._defaults.merge["firewall_policy"]
}

module "firewall_rule_collection_group" {
  source = "./modules/hashicorp/azurerm/firewall_policy_rule_collection_group"

  firewall_policy_rule_collection_group_data = module._defaults.merge["firewall_policy_rule_collection_group"]
  firewall_policy_output                     = module.firewall_policy.firewall_policy_output_names

}

module "key_vault" {
  source = "./modules/hashicorp/azurerm/key_vault"

  key_vault_data = module._defaults.merge["key_vault"]
}

module "key_vault_access_policy" {
  source = "./modules/hashicorp/azurerm/key_vault_access_policy"

  key_vault_access_policy_data  = module._defaults.merge["key_vault_access_policy"]
  user_assigned_identity_output = module.user_assigned_identity.user_assigned_identity_output_names
  key_vault_output              = module.key_vault.key_vault_output_names
  #depends_on     = [module.user_assigned_identity]
}

module "key_vault_certificate" {
  source = "./modules/hashicorp/azurerm/key_vault_certificate"

  key_vault_certificate_data = module._defaults.merge["key_vault_certificate"]
  key_vault_output           = module.key_vault.key_vault_output_names
}

module "key_vault_key" {
  source = "./modules/hashicorp/azurerm/key_vault_key"

  key_vault_key_data = module._defaults.merge["key_vault_key"]
  depends_on         = [module.key_vault, module.private_endpoint, module.key_vault_managed_hardware_security_module]

}

module "key_vault_managed_hardware_security_module" {
  source = "./modules/hashicorp/azurerm/key_vault_managed_hardware_security_module"

  key_vault_managed_hardware_security_module_data = module._defaults.merge["key_vault_managed_hardware_security_module"]
}

module "key_vault_managed_hardware_security_module_role_assignment" {
  source = "./modules/hashicorp/azurerm/key_vault_managed_hardware_security_module_role_assignment"

  key_vault_managed_hardware_security_module_role_assignment_data = module._defaults.merge["key_vault_managed_hardware_security_module_role_assignment"]
}

module "key_vault_secret" {
  source = "./modules/hashicorp/azurerm/key_vault_secret"

  key_vault_secret_data  = module._defaults.merge["key_vault_secret"]
  tls_private_key_output = module.tls_private_key.tls_private_key_output

  depends_on = [module.key_vault, module.key_vault_managed_hardware_security_module]
}

module "lb" {
  source = "./modules/hashicorp/azurerm/lb"

  lb_data                           = module._defaults.merge["lb"]
  lb_frontend_ip_configuration_data = module._defaults.merge["lb_frontend_ip_configuration"]
  subnet_output                     = module.subnet.subnet_output_names
}

module "lb_backend_address_pool" {
  source = "./modules/hashicorp/azurerm/lb_backend_address_pool"

  lb_backend_address_pool_data = module._defaults.merge["lb_backend_address_pool"]
  lb_output                    = module.lb.lb_output_names
}

module "lb_backend_address_pool_address" {
  source = "./modules/hashicorp/azurerm/lb_backend_address_pool_address"

  lb_backend_address_pool_address_data = module._defaults.merge["lb_backend_address_pool_address"]
}

module "lb_probe" {
  source = "./modules/hashicorp/azurerm/lb_probe"

  lb_probe_data = module._defaults.merge["lb_probe"]
  lb_output     = module.lb.lb_output_names
}

module "lb_rule" {
  source = "./modules/hashicorp/azurerm/lb_rule"

  lb_rule_data                   = module._defaults.merge["lb_rule"]
  lb_output                      = module.lb.lb_output_names
  lb_backend_address_pool_output = module.lb_backend_address_pool.lb_backend_address_pool_output_names
  lb_probe_output                = module.lb_probe.lb_probe_output_names
}

module "linux_virtual_machine" {
  source = "./modules/hashicorp/azurerm/linux_virtual_machines"

  linux_virtual_machine_data = module._defaults.merge["linux_virtual_machine"]
}

module "local_network_gateway" {
  source = "./modules/hashicorp/azurerm/local_network_gateway"

  local_network_gateway_data = module._defaults.merge["local_network_gateway"]
}

module "log_analytics_workspace" {
  source = "./modules/hashicorp/azurerm/log_analytics_workspace"

  log_analytics_workspace_data = module._defaults.merge["log_analytics_workspace"]
}

module "managed_disk" {
  source = "./modules/hashicorp/azurerm/managed_disk"

  managed_disk_data = module._defaults.merge["managed_disk"]
}

module "management_lock" {
  source = "./modules/hashicorp/azurerm/management_lock"

  management_lock_data = module._defaults.merge["management_lock"]
}

module "marketplace_agreement" {
  source = "./modules/hashicorp/azurerm/marketplace_agreement"

  marketplace_agreement_data = module._defaults.merge["marketplace_agreement"]
}

module "monitor_activity_log_alert" {
  source = "./modules/hashicorp/azurerm/monitor_activity_log_alert"

  monitor_activity_log_alert_data = module._defaults.merge["monitor_activity_log_alert"]
  resource_group_output           = module.resource_group.resource_group_output_names
}

module "monitor_diagnostic_setting" {
  source = "./modules/hashicorp/azurerm/monitor_diagnostic_setting"

  monitor_diagnostic_setting_data = module._defaults.merge["monitor_diagnostic_setting"]
}

module "mssql_firewall_rule" {
  source = "./modules/hashicorp/azurerm/mssql_firewall_rule"

  mssql_firewall_rule_data = module._defaults.merge["mssql_firewall_rule"]
  mssql_server_output      = module.mssql_server.mssql_server_output_names
}

module "mssql_server" {
  source = "./modules/hashicorp/azurerm/mssql_server"

  mssql_server_data = module._defaults.merge["mssql_server"]
}
module "mssql_database" {
  source              = "mssql_database"
  mssql_database_data = module._defaults.merge["mssql_database"]
}

module "mssql_server_extended_auditing_policy" {
  source = "./modules/hashicorp/azurerm/mssql_server_extended_auditing_policy"

  mssql_server_extended_auditing_policy_data = module._defaults.merge["mssql_server_extended_auditing_policy"]
  mssql_server_output                        = module.mssql_server.mssql_server_output_names
}

module "mssql_server_security_alert_policy" {
  source = "./modules/hashicorp/azurerm/mssql_server_security_alert_policy"

  mssql_server_security_alert_policy_data = module._defaults.merge["mssql_server_security_alert_policy"]
  mssql_server_output                     = module.mssql_server.mssql_server_output_names
  storage_account_output                  = module.storage_account.storage_account_output_names
  depends_on                              = [module.storage_account]
}

module "mssql_virtual_network_rule" {
  source = "./modules/hashicorp/azurerm/mssql_virtual_network_rule"

  mssql_virtual_network_rule_data = module._defaults.merge["mssql_virtual_network_rule"]
  mssql_server_output             = module.mssql_server.mssql_server_output_names

}

module "nat_gateway" {
  source = "./modules/hashicorp/azurerm/nat_gateway"

  nat_gateway_data = module._defaults.merge["nat_gateway"]
}

module "nat_gateway_public_ip_prefix_association" {
  source = "./modules/hashicorp/azurerm/nat_gateway_public_ip_prefix_association"

  nat_gateway_public_ip_prefix_association_data = module._defaults.merge["nat_gateway_public_ip_prefix_association"]
  public_ip_prefix_output                       = module.public_ip_prefix.public_ip_prefix_output_names
  nat_gateway_output                            = module.nat_gateway.nat_gateway_output_names
}

module "network_interface" {
  source = "./modules/hashicorp/azurerm/network_interface"

  network_interface_data = module._defaults.merge["network_interface"]
  resource_group_output  = module.resource_group.resource_group_output_names
}

module "network_interface_backend_address_pool_association" {
  source = "./modules/hashicorp/azurerm/network_interface_backend_address_pool_association"

  network_interface_backend_address_pool_association_data = module._defaults.merge["network_interface_backend_address_pool_association"]
  network_interface_output                                = module.palo_alto.network_interface_output_names
  lb_backend_address_pool_output                          = module.lb_backend_address_pool.lb_backend_address_pool_output_names
}

module "network_interface_security_group_association" {
  source = "./modules/hashicorp/azurerm/network_interface_security_group_association"

  network_interface_security_group_association_data = module._defaults.merge["network_interface_security_group_association"]
  network_interface_output                          = module.network_interface.network_interface_output_names
  network_security_group_output                     = module.network_security_group.network_security_group_output_names
}

module "network_security_group" {
  source = "./modules/hashicorp/azurerm/network_security_group"

  network_security_group_data = module._defaults.merge["network_security_group"]
}

module "network_security_rule" {
  source = "./modules/hashicorp/azurerm/network_security_rule"

  network_security_rule_data    = module._defaults.merge["network_security_rule"]
  network_security_group_output = module.network_security_group.network_security_group_output_names
}

module "network_watcher_flow_log" {
  source = "./modules/hashicorp/azurerm/network_watcher_flow_log"

  network_watcher_flow_log_data = module._defaults.merge["network_watcher_flow_log"]
  network_security_group_output = module.network_security_group.network_security_group_output_names
  storage_acccount_output       = module.storage_account.storage_account_output_names
}

module "palo_alto" {
  source = "./modules/hashicorp/azurerm/palo_alto"

  fw_data                 = module._defaults.merge["palo_alto"]
  availability_set_output = module.availability_set.availability_set_output
  #public_ip_prefix_output = data.terraform_remote_state.remote_state.outputs.public_ip_prefix.public_ip_prefix_output
  subnet_output         = module.subnet.subnet_output_names
  ssh_public_key_output = module.ssh_public_key.ssh_public_key_output_names
  depends_on            = [module.marketplace_agreement]
}

module "palo_alto_virtual_machine_data_disk_attachment" {
  source = "./modules/hashicorp/azurerm/virtual_machine_data_disk_attachment"

  virtual_machine_data_disk_attachment_data = module._defaults.merge["palo_alto_virtual_machine_data_disk_attachment"]
  managed_disk_output                       = module.managed_disk.managed_disk_output_names
  virtual_machine_output                    = module.palo_alto.virtual_machine_output
}

module "private_dns_resolver" {
  source = "./modules/hashicorp/azurerm/private_dns_resolver"

  private_dns_resolver_data = module._defaults.merge["private_dns_resolver"]
  virtual_network_output    = module.virtual_network.virtual_network_output_names
}

module "private_dns_resolver_dns_forwarding_ruleset" {
  source = "./modules/hashicorp/azurerm/private_dns_resolver_dns_forwarding_ruleset"

  private_dns_resolver_dns_forwarding_ruleset_data = module._defaults.merge["private_dns_resolver_dns_forwarding_ruleset"]
  private_dns_resolver_outbound_endpoint_output    = module.private_dns_resolver_outbound_endpoint.private_dns_resolver_outbound_endpoint_output_names
}

module "private_dns_resolver_forwarding_rule" {
  source = "./modules/hashicorp/azurerm/private_dns_resolver_forwarding_rule"

  private_dns_resolver_forwarding_rule_data         = module._defaults.merge["private_dns_resolver_forwarding_rule"]
  private_dns_resolver_dns_forwarding_ruleset_ouput = module.private_dns_resolver_dns_forwarding_ruleset.private_dns_resolver_dns_forwarding_ruleset_output_names
}

module "private_dns_resolver_inbound_endpoint" {
  source = "./modules/hashicorp/azurerm/private_dns_resolver_inbound_endpoint"

  private_dns_resolver_inbound_endpoint_data = var.private_dns_resolver_inbound_endpoint_data
}

module "private_dns_resolver_outbound_endpoint" {
  source = "./modules/hashicorp/azurerm/private_dns_resolver_outbound_endpoint"

  private_dns_resolver_outbound_endpoint_data = module._defaults.merge["private_dns_resolver_outbound_endpoint"]
  private_dns_resolver_output                 = module.private_dns_resolver.private_dns_resolver_output_names
  subnet_output                               = module.subnet.subnet_output_names
}

module "private_dns_resolver_virtual_network_link" {
  source = "./modules/hashicorp/azurerm/private_dns_resolver_virtual_network_link"

  private_dns_resolver_virtual_network_link_data     = module._defaults.merge["private_dns_resolver_virtual_network_link"]
  virtual_network_output                             = module.virtual_network.virtual_network_output_names
  private_dns_resolver_dns_forwarding_ruleset_output = module.private_dns_resolver_dns_forwarding_ruleset.private_dns_resolver_dns_forwarding_ruleset_output_names
}

module "private_endpoint" {
  source = "./modules/hashicorp/azurerm/private_endpoint"

  private_endpoint_data                             = module._defaults.merge["private_endpoint"]
  mssql_server_output                               = module.mssql_server.mssql_server_output_names
  storage_account_output                            = module.storage_account.storage_account_output_names
  key_vault_output                                  = module.key_vault.key_vault_output_names
  key_vault_managed_hardware_security_module_output = module.key_vault_managed_hardware_security_module.key_vault_managed_hardware_security_module_output_names
  recovery_services_vault_output                    = module.recovery_services_vault.recovery_services_vault_output_names
  subnet_output                                     = module.subnet.subnet_output_names
  depends_on                                        = [module.key_vault, module.key_vault_managed_hardware_security_module]
}

module "public_ip" {
  source = "./modules/hashicorp/azurerm/public_ip"

  public_ip_data = module._defaults.merge["public_ip"]
}

module "public_ip_prefix" {
  source = "./modules/hashicorp/azurerm/public_ip_prefix"

  public_ip_prefix_data = module._defaults.merge["public_ip_prefix"]
}

module "recovery_services_vault" {
  source = "./modules/hashicorp/azurerm/recovery_services_vault"

  recovery_services_vault_data = module._defaults.merge["recovery_services_vault"]
  depends_on                   = [module.resource_group]
}

module "resource_group" {
  source = "./modules/hashicorp/azurerm/resource_group"

  resource_group_data = module._defaults.merge["resource_group"]
}

module "role_assignment" {
  source = "./modules/hashicorp/azurerm/role_assignment"

  role_assignment_data = module._defaults.merge["role_assignment"]
}

module "route_table" {
  source = "./modules/hashicorp/azurerm/route_table"

  route_table_data      = module._defaults.merge["route_table"]
  resource_group_output = module.resource_group.resource_group_output_names
}

module "security_center_contact" {
  source                       = "./modules/hashicorp/azurerm/security_center_contact"
  security_center_contact_data = var.security_center_contact_data
}

module "ssh_public_key" {
  source = "./modules/hashicorp/azurerm/ssh_public_key"

  ssh_public_key_data = module._defaults.merge["ssh_public_key"]
}

module "storage_account" {
  source = "./modules/hashicorp/azurerm/storage_account"

  storage_account_data = module._defaults.merge["storage_account"]
}

module "storage_container" {
  source = "./modules/hashicorp/azurerm/storage_container"

  storage_container_data = module._defaults.merge["storage_container"]
  depends_on             = [module.storage_account]

}

module "storage_share" {
  source = "./modules/hashicorp/azurerm/storage_share"

  storage_share_data = module._defaults.merge["storage_share"]
}

module "storage_share_directory" {
  source = "./modules/hashicorp/azurerm/storage_share_directory"

  storage_share_directory_data = module._defaults.merge["storage_share_directory"]
}

module "subnet" {
  source = "./modules/hashicorp/azurerm/subnet"

  subnet_data            = module._defaults.merge["subnet"]
  resource_group_output  = module.resource_group.resource_group_output_names
  virtual_network_output = module.virtual_network.virtual_network_output_names
}

module "subnet_nat_gateway_association" {
  source = "./modules/hashicorp/azurerm/subnet_nat_gateway_association"

  subnet_nat_gateway_association_data = module._defaults.merge["subnet_nat_gateway_association"]
  subnet_output                       = module.subnet.subnet_output_names
  nat_gateway_output                  = module.nat_gateway.nat_gateway_output_names
}

module "subnet_network_security_group_association" {
  source = "./modules/hashicorp/azurerm/subnet_network_security_group_association"

  subnet_network_security_group_association_data = module._defaults.merge["subnet_network_security_group_association"]
  network_security_group_output                  = module.network_security_group.network_security_group_output_names
  subnet_output                                  = module.subnet.subnet_output_names
  depends_on                                     = [module.resource_group]

}

module "subnet_route_table_association_data" {
  source = "./modules/hashicorp/azurerm/subnet_route_table_association"

  subnet_route_table_association_data = module._defaults.merge["subnet_route_table_association"]
  subnet_output                       = module.subnet.subnet_output_names
  route_table_output                  = module.route_table.route_table_output_names
}

module "user_assigned_identity" {
  source = "./modules/hashicorp/azurerm/user_assigned_identity"

  user_assigned_identity_data = module._defaults.merge["user_assigned_identity"]
}

module "virtual_machine_extension" {
  source = "./modules/hashicorp/azurerm/virtual_machine_extension"

  virtual_machine_extension_data = module._defaults.merge["virtual_machine_extension"]
  virtual_machine_output         = module.linux_virtual_machine.linux_virtual_machine_output_names

}

module "virtual_network" {
  source = "./modules/hashicorp/azurerm/virtual_network"

  virtual_network_data  = module._defaults.merge["virtual_network"]
  resource_group_output = module.resource_group.resource_group_output_names
}

module "virtual_network_gateway" {
  source = "./modules/hashicorp/azurerm/virtual_network_gateway"

  virtual_network_gateway_data = module._defaults.merge["virtual_network_gateway"]
  public_ip_output             = module.public_ip.public_ip_output_names
  subnet_output                = module.subnet.subnet_output_names
}

module "virtual_network_gateway_connection" {
  source = "./modules/hashicorp/azurerm/virtual_network_gateway_connection"
  providers = {
    azurerm                = azurerm
    azurerm.Cloud_Services = azurerm.Cloud_Services
  }
  virtual_network_gateway_connection_data    = module._defaults.merge["virtual_network_gateway_connection"]
  express_route_circuit_authorization_output = module.express_route_circuit_authorization.express_route_circuit_authorization_output_names
  express_route_circuit_authorization_data   = try(var.vngw_remote_express_route_circuit_authorization_data, {})
}

module "virtual_network_gateway_nat_rule" {
  source = "./modules/hashicorp/azurerm/virtual_network_gateway_nat_rule"

  virtual_network_gateway_nat_rule_data = var.virtual_network_gateway_nat_rule_data
}

module "virtual_network_peering" {
  source = "./modules/hashicorp/azurerm/virtual_network_peering"

  virtual_network_peering_data = module._defaults.merge["virtual_network_peering"]
  resource_group_output        = module.resource_group.resource_group_output_names
}

module "windows_virtual_machine" {
  source = "./modules/hashicorp/azurerm/windows_virtual_machines"

  windows_virtual_machine_data = module._defaults.merge["windows_virtual_machine"]
  resource_group_output        = module.resource_group.resource_group_output_names

  # This was removed to troubleshoot a problem with subnets. Terraform kept detecting subnet changes when there weren't any.
  # depends_on = [ module.resource_group ]
}

