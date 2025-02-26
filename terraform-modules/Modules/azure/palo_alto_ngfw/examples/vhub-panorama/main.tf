# Example deployment of a Palo Alto firewall with Panorama management in a Virtual Hub

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
  firewall_type         = "vhub_panorama"
  name                  = "fw-example"
  resource_group_name   = azurerm_resource_group.example.name
  location              = azurerm_resource_group.example.location
  panorama_base64_config = "e2RnbmFtZTogY25nZnctYXotZXhhbXBsZSwgdHBsbmFtZTogY25nZnctZXhhbXBsZS10ZW1wbGF0ZS1zdGFjaywgZXhhbXBsZS1wYW5vcmFtYS1zZXJ2ZXI6IDE5Mi4xNjguMC4xLCB2bS1hdXRoLWtleTogMDAwMDAwMDAwMDAwMDAwLCBleHBpcnk6IDIwMjQvMDcvMzF9Cg=="
  
  # Virtual Hub settings
  virtual_hub_id      = azurerm_virtual_hub.example.id
  
  # Network settings
  public_ip_address_ids = [azurerm_public_ip.example.id]
  
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

output "virtual_network_appliance_id" {
  value = module.palo_alto_firewall.virtual_network_appliance_id
}