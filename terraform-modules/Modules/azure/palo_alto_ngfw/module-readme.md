# Azure Palo Alto Firewall Terraform Module

This Terraform module deploys Palo Alto Networks Cloud NGFW (Next Generation Firewall) in Azure using various deployment modes. The module supports the following deployment types:

- **Virtual Network with Local Rulestack**: Deploy a firewall in an Azure VNet with rules managed in Azure
- **Virtual Network with Panorama**: Deploy a firewall in an Azure VNet with rules managed by Panorama
- **Virtual Hub with Local Rulestack**: Deploy a firewall in an Azure Virtual WAN Hub with rules managed in Azure
- **Virtual Hub with Panorama**: Deploy a firewall in an Azure Virtual WAN Hub with rules managed by Panorama

## Features

- Flexible deployment options to fit various network architectures
- Support for both local rulestack (Azure-managed) and Panorama-managed firewalls
- Support for VNet and Virtual WAN Hub deployments
- Simple configuration with sensible defaults
- Comprehensive examples for all deployment types

## Usage

```hcl
module "palo_alto_firewall" {
  source = "path/to/module"
  
  # Required variables
  firewall_type       = "vnet_local_rulestack"
  name                = "fw-example"
  resource_group_name = "rg-example"
  location            = "West Europe"
  
  # Network settings - VNet deployment
  public_ip_address_ids = ["/subscriptions/.../resourceGroups/.../providers/Microsoft.Network/publicIPAddresses/pip-example"]
  virtual_network_id    = "/subscriptions/.../resourceGroups/.../providers/Microsoft.Network/virtualNetworks/vnet-example"
  trusted_subnet_id     = "/subscriptions/.../resourceGroups/.../providers/Microsoft.Network/virtualNetworks/vnet-example/subnets/subnet-trust"
  untrusted_subnet_id   = "/subscriptions/.../resourceGroups/.../providers/Microsoft.Network/virtualNetworks/vnet-example/subnets/subnet-untrust"
  
  # Local rulestack settings
  local_rulestack_name = "rulestack-example"
}
```

See the [examples directory](./examples) for more detailed usage examples.

## Supported Firewall Types

The module supports four types of deployments, selected using the `firewall_type` variable:

| Firewall Type | Description |
|---------------|-------------|
| `vnet_local_rulestack` | Deploys a Palo Alto NGFW in a Virtual Network with a local rulestack (managed in Azure) |
| `vnet_panorama` | Deploys a Palo Alto NGFW in a Virtual Network managed by Panorama |
| `vhub_local_rulestack` | Deploys a Palo Alto NGFW in a Virtual WAN Hub with a local rulestack (managed in Azure) |
| `vhub_panorama` | Deploys a Palo Alto NGFW in a Virtual WAN Hub managed by Panorama |

## Requirements

- Azure subscription
- Terraform 1.0+
- AzureRM provider 3.0+
- Appropriate Azure permissions to deploy the resources

## Input Variables

### Core Variables

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| `firewall_type` | Type of Palo Alto firewall to deploy | string | Yes |
| `name` | Name of the Palo Alto firewall | string | Yes |
| `resource_group_name` | Name of the resource group | string | Yes |
| `location` | Azure region where the firewall will be deployed | string | Yes |
| `create_resource_group` | Whether to create a resource group for the firewall | bool | No |
| `tags` | Tags to apply to all created resources | map(string) | No |

### Marketplace & Plan Variables

| Name | Description | Type | Default |
|------|-------------|------|---------|
| `marketplace_offer_id` | The marketplace offer ID | string | `"pan_swfw_cloud_ngfw"` |
| `plan_id` | The billing plan ID as published by Liftr.PAN | string | `"panw-cngfw-payg"` |

### Network Variables

| Name | Description | Type | Required for |
|------|-------------|------|-------------|
| `public_ip_address_ids` | List of public IP address IDs to use for the firewall | list(string) | All |
| `virtual_network_id` | ID of the virtual network | string | VNet deployments |
| `trusted_subnet_id` | ID of the trusted subnet | string | VNet deployments |
| `untrusted_subnet_id` | ID of the untrusted subnet | string | VNet deployments |
| `virtual_hub_id` | ID of the virtual hub | string | VHub deployments |
| `egress_nat_ip_address_ids` | List of public IP address IDs to use for egress NAT | list(string) | Optional |
| `trusted_address_ranges` | List of trusted IP address ranges | list(string) | Optional |

### Local Rulestack Variables

| Name | Description | Type | Required for |
|------|-------------|------|-------------|
| `local_rulestack_name` | Name of the local rulestack | string | Local rulestack deployments |
| `local_rulestack_description` | Description for the local rulestack | string | Optional |
| `anti_spyware_profile` | The setting to use for Anti-Spyware | string | Optional |
| `anti_virus_profile` | The setting to use for Anti-Virus | string | Optional |
| `dns_subscription` | The setting to use for DNS Subscription | string | Optional |
| `file_blocking_profile` | The setting to use for the File Blocking Profile | string | Optional |
| `url_filtering_profile` | The setting to use for the URL Filtering Profile | string | Optional |
| `vulnerability_profile` | The setting to use for the Vulnerability Profile | string | Optional |

### Panorama Variables

| Name | Description | Type | Required for |
|------|-------------|------|-------------|
| `panorama_base64_config` | The Base64 Encoded configuration value for connecting to Panorama | string | Panorama deployments |

For a complete list of variables, see [variables.tf](./variables.tf).

## Output Variables

| Name | Description |
|------|-------------|
| `firewall_id` | The ID of the deployed firewall |
| `firewall_name` | The name of the deployed firewall |
| `local_rulestack_id` | The ID of the local rulestack (if created) |
| `virtual_network_appliance_id` | The ID of the virtual network appliance (if created) |
| `panorama_details` | Panorama details for the deployed firewall (if using Panorama) |

## Examples

### VNet with Local Rulestack

```hcl
module "palo_alto_firewall" {
  source = "../../"
  
  firewall_type       = "vnet_local_rulestack"
  name                = "fw-example"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  
  public_ip_address_ids = [azurerm_public_ip.example.id]
  virtual_network_id    = azurerm_virtual_network.example.id
  trusted_subnet_id     = azurerm_subnet.trust.id
  untrusted_subnet_id   = azurerm_subnet.untrust.id
  
  local_rulestack_name  = "rulestack-example"
}
```

### VHub with Panorama

```hcl
module "palo_alto_firewall" {
  source = "../../"
  
  firewall_type         = "vhub_panorama"
  name                  = "fw-example"
  resource_group_name   = azurerm_resource_group.example.name
  location              = azurerm_resource_group.example.location
  panorama_base64_config = "YOUR_BASE64_ENCODED_CONFIG"
  
  virtual_hub_id        = azurerm_virtual_hub.example.id
  public_ip_address_ids = [azurerm_public_ip.example.id]
}
```

For more examples, see the [examples directory](./examples).

## Important Notes

- For Virtual Hub deployments, ensure the Virtual Hub is created with the tag `"hubSaaSPreview" = "true"`
- For VNet deployments, ensure the subnets are delegated to `PaloAltoNetworks.Cloudngfw/firewalls`
- The default plan ID is set to `panw-cngfw-payg` (the former `panw-cloud-ngfw-payg` is deprecated)

## License

This module is licensed under the MIT License.
