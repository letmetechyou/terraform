resource "azurerm_lb_outbound_rule" "lb_outbound_rule" {
  for_each = {for key, value in var.lb_outbound_rule_data : key => value if value.enabled}
  #Required
  name = each.value.name
  loadbalancer_id = coalesce(
    try(each.value.loadbalancer_id, null),
    try(var.lb_output["${each.value.loadbalancer_name}"].id, null),
    try(var.lb_output["${each.value.loadbalancer_key}"].id, null)
  )
  protocol = each.value.protocol
  backend_address_pool_id = try(coalesce(
    try(each.value.backend_address_pool_id, null),
    try(var.lb_backend_address_pool_output["${each.value.backend_address_pool_name}"].id, null),
  ), null)

  #Optional
  dynamic frontend_ip_configuration {
    for_each = each.value.frontend_ip_configuration != null ? range(length(each.value.frontend_ip_configuration)) : []
    content {
      name = each.value.frontend_ip_configuration[frontend_ip_configuration.key].name
    }
  }
  enable_tcp_reset = each.value.enable_tcp_reset
  allocated_outbound_ports = each.value.allocated_outbound_ports
  idle_timeout_in_minutes = each.value.idle_timeout_in_minutes

  lifecycle {
    prevent_destroy = false
  }
}