# Example deployment of a Palo Alto firewall with local rulestack in a Virtual Hub

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "rg-example"
  location = "West Europe"
}

resource "azurerm_virtual_wan" "example" {
  name                = "vwan-example"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
}

resource "azurerm_virtual_hub" "example" {
  name                = "vhub-example"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  virtual_wan_id      = azurerm_virtual_wan.example.id
  address_prefix      = "10.0.0.0/23"

  tags = {
    "hubSaaSPreview" = "true"  # Required for Palo Alto deployment
  }
}

resource "azurerm_public_ip" "example" {
  name                = "pip-example"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

module "palo_alto_firewall" {
  source = "../../"
  
  # Core settings
  firewall_type       = "vhub_local_rulestack"
  name                = "fw-example"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  
  # Virtual Hub settings
  virtual_hub_id      = azurerm_virtual_hub.example.id
  
  # Network settings
  public_ip_address_ids = [azurerm_public_ip.example.id]
  
  # Local rulestack settings
  local_rulestack_name  = "rulestack-example"
  anti_spyware_profile  = "BestPractice"
  url_filtering_profile = "BestPractice"

  # DNS settings
  use_azure_dns = true
  
  # Tags
  tags = {
    Environment = "Example"
    Department  = "Security"
  }
}

output "firewall_id" {
  value = module.palo_alto_firewall.firewall_id
}

output "local_rulestack_id" {
  value = module.palo_alto_firewall.local_rulestack_id
}

output "virtual_network_appliance_id" {
  value = module.palo_alto_firewall.virtual_network_appliance_id
}