variable "global_defaults" {
  default = {}
}
variable "environment_defaults" {
  default = {}
}

#Module Variables

variable "api_management_data" { default = {} }
variable "api_management_data_v2" { default = {} }
variable "application_gateway_data" { default = {} }
variable "availability_set_data" { default = {} }
variable "azurerm_linux_virtual_machine_data" { default = {} }
variable "backup_policy_vm_data" { default = {} }
variable "data_protection_backup_vault_data" { default = {} }
variable "eventhub_data" { default = {} }
variable "express_route_circuit_authorization_data" { default = {} }
variable "express_route_connection_data" { default = {} }
variable "firewall_data" { default = {} }
variable "firewall_policy_data" { default = {} }
variable "firewall_policy_rule_collection_group_data" { default = {} }
variable "key_vault_data" { default = {} }
variable "key_vault_access_policy_data" { default = {} }
variable "key_vault_certificate_data" { default = {} }
variable "key_vault_key_data" { default = {} }
variable "key_vault_managed_hardware_security_module_data" { default = {} }
variable "key_vault_managed_hardware_security_module_role_assignment_data" { default = {} }
variable "key_vault_secret_data" { default = {} }
variable "lb_data" { default = {} }
variable "lb_frontend_ip_configuration_data" { default = {} }
variable "lb_backend_address_pool_data" { default = {} }
variable "lb_backend_address_pool_address_data" { default = {} }
variable "lb_probe_data" { default = {} }
variable "lb_rule_data" { default = {} }
variable "linux_virtual_machine_data" { default = {} }
variable "local_network_gateway_data" { default = {} }
variable "log_analytics_workspace_data" { default = {} }
variable "managed_disk_data" { default = {} }
variable "management_lock_data" { default = {} }
variable "marketplace_agreement_data" { default = {} }
variable "monitor_activity_log_alert_data" { default = {} }
variable "monitor_diagnostic_setting_data" { default = {} }
variable "mssql_firewall_rule_data" { default = {} }
variable "mssql_server_data" { default = {} }
variable "mssql_server_extended_auditing_policy_data" { default = {} }
variable "mssql_server_security_alert_policy_data" { default = {} }
variable "mssql_virtual_network_rule_data" { default = {} }
variable "nat_gateway_data" { default = {} }
variable "nat_gateway_public_ip_prefix_association_data" { default = {} }
variable "network_interface_data" { default = {} }
variable "network_interface_backend_address_pool_association_data" { default = {} }
variable "network_interface_security_group_association_data" { default = {} }
variable "network_security_group_data" { default = {} }
variable "network_security_rule_data" { default = {} }
variable "network_watcher_flow_log_data" { default = {} }
variable "palo_alto_data" { default = {} }
variable "palo_alto_virtual_machine_data_disk_attachment_data" { default = {} }
variable "private_dns_resolver_data" { default = {} }
variable "private_dns_resolver_dns_forwarding_ruleset_data" { default = {} }
variable "private_dns_resolver_forwarding_rule_data" { default = {} }
variable "private_dns_resolver_outbound_endpoint_data" { default = {} }
variable "private_dns_resolver_virtual_network_link_data" { default = {} }
variable "private_endpoint_data" { default = {} }
variable "public_ip_data" { default = {} }
variable "public_ip_prefix_data" { default = {} }
variable "recovery_services_vault_data" { default = {} }
variable "resource_group_data" { default = {} }
variable "role_assignment_data" { default = {} }
variable "route_table_data" { default = {} }
variable "ssh_public_key_data" { default = {} }
variable "storage_account_data" { default = {} }
variable "storage_container_data" { default = {} }
variable "storage_share_data" { default = {} }
variable "storage_share_directory_data" { default = {} }
variable "subnet_data" { default = {} }
variable "subnet_nat_gateway_association_data" { default = {} }
variable "subnet_network_security_group_association_data" { default = {} }
variable "subnet_route_table_association_data" { default = {} }
variable "tls_private_key_data" { default = {} }
variable "user_assigned_identity_data" { default = {} }
variable "virtual_machine_extension_data" { default = {} }
variable "virtual_network_data" { default = {} }
variable "virtual_network_gateway_data" { default = {} }
variable "virtual_network_gateway_connection_data" { default = {} }
variable "virtual_network_peering_data" { default = {} }
variable "windows_virtual_machine_data" { default = {} }
