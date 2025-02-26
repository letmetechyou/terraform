output "monitor_activity_log_alert_output" {
  value = zipmap(values(azurerm_monitor_activity_log_alert.monitor_activity_log_alert)[*].name, values(azurerm_monitor_activity_log_alert.monitor_activity_log_alert)[*])
}

output "monitor_activity_log_alert_output_names" {
  value = { for key, value in azurerm_monitor_activity_log_alert.monitor_activity_log_alert : value.name => value }
}
