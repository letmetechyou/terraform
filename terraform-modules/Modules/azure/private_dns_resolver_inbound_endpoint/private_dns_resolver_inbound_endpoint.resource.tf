resource "azurerm_private_dns_resolver_inbound_endpoint" "private_dns_resolver_inbound_endpoint" {
  for_each = { for key, value in var.private_dns_resolver_inbound_endpoint_data : key => value if value.enabled }

  # Required Arguments
  private_dns_resolver_id = each.value.private_dns_resolver_id
  location                = each.value.location
  name                    = each.value.name

  # Required Blocks 

  ip_configurations {

    # Required
    subnet_id = each.value.ip_configurations.subnet_id

    # Optional
    private_ip_allocation_method = each.value.ip_configurations.private_ip_allocation_method
    private_ip_address           = each.value.ip_configurations.private_ip_address

  }


  # Optional Arguments
  tags = each.value.tags


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
