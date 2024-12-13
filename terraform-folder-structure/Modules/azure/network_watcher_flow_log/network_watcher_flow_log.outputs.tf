output "network_watcher_flow_log_output" {
  value = zipmap(values(azurerm_network_watcher_flow_log.network_watcher_flow_log)[*].name, values(azurerm_network_watcher_flow_log.network_watcher_flow_log)[*])
}

output "network_watcher_flow_log_output_names" {
  value = { for key, value in azurerm_network_watcher_flow_log.network_watcher_flow_log : value.name => value }
}
