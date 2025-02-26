# main.tf
# Core module file that selects the appropriate Palo Alto firewall type to deploy

locals {
  # Normalize firewall type to handle case differences
  firewall_type_normalized = lower(var.firewall_type)
  
  # Determine if each firewall type should be created
  create_vnet_local_rulestack   = local.firewall_type_normalized == "vnet_local_rulestack"
  create_vnet_panorama          = local.firewall_type_normalized == "vnet_panorama"
  create_vhub_local_rulestack   = local.firewall_type_normalized == "vhub_local_rulestack"
  create_vhub_panorama          = local.firewall_type_normalized == "vhub_panorama"
  
  # Determine if we need to create a local rulestack
  create_local_rulestack = local.create_vnet_local_rulestack || local.create_vhub_local_rulestack
  
  # Determine if we need to create a virtual network appliance
  create_virtual_network_appliance = local.create_vhub_local_rulestack || local.create_vhub_panorama
}

# Resource Group - Use existing if provided, otherwise create one
resource "azurerm_resource_group" "this" {
  count    = var.create_resource_group ? 1 : 0
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

locals {
  resource_group_name = var.create_resource_group ? azurerm_resource_group.this[0].name : var.resource_group_name
}

# Local Rulestack - only created if using a local rulestack deployment
resource "azurerm_palo_alto_local_rulestack" "this" {
  count               = local.create_local_rulestack ? 1 : 0
  name                = var.local_rulestack_name != null ? var.local_rulestack_name : "${var.name}-rulestack"
  resource_group_name = local.resource_group_name
  location            = var.location
  
  description           = var.local_rulestack_description
  anti_spyware_profile  = var.anti_spyware_profile
  anti_virus_profile    = var.anti_virus_profile
  dns_subscription      = var.dns_subscription
  file_blocking_profile = var.file_blocking_profile
  url_filtering_profile = var.url_filtering_profile
  vulnerability_profile = var.vulnerability_profile
}

# Virtual Network Appliance - only created if using a vhub deployment
resource "azurerm_palo_alto_virtual_network_appliance" "this" {
  count         = local.create_virtual_network_appliance ? 1 : 0
  name          = var.virtual_network_appliance_name != null ? var.virtual_network_appliance_name : "${var.name}-vna"
  virtual_hub_id = var.virtual_hub_id
}

# Next Generation Firewall - Virtual Network with Local Rulestack
resource "azurerm_palo_alto_next_generation_firewall_virtual_network_local_rulestack" "this" {
  count               = local.create_vnet_local_rulestack ? 1 : 0
  name                = var.name
  resource_group_name = local.resource_group_name
  rulestack_id        = azurerm_palo_alto_local_rulestack.this[0].id
  
  marketplace_offer_id = var.marketplace_offer_id
  plan_id             = var.plan_id
  tags                = var.tags

  network_profile {
    public_ip_address_ids   = var.public_ip_address_ids
    trusted_address_ranges  = var.trusted_address_ranges
    egress_nat_ip_address_ids = var.egress_nat_ip_address_ids

    vnet_configuration {
      virtual_network_id  = var.virtual_network_id
      trusted_subnet_id   = var.trusted_subnet_id
      untrusted_subnet_id = var.untrusted_subnet_id
    }
  }

  # DNS settings if specified
  dynamic "dns_settings" {
    for_each = var.dns_servers != null || var.use_azure_dns != null ? [1] : []
    content {
      dns_servers    = var.dns_servers
      use_azure_dns  = var.use_azure_dns
    }
  }

  # Destination NAT rules if specified
  dynamic "destination_nat" {
    for_each = var.destination_nat_rules
    content {
      name     = destination_nat.value.name
      protocol = destination_nat.value.protocol
      
      frontend_config {
        port                  = destination_nat.value.frontend_port
        public_ip_address_id  = destination_nat.value.frontend_public_ip_address_id
      }
      
      backend_config {
        port              = destination_nat.value.backend_port
        public_ip_address = destination_nat.value.backend_public_ip_address
      }
    }
  }
}

# Next Generation Firewall - Virtual Network with Panorama
resource "azurerm_palo_alto_next_generation_firewall_virtual_network_panorama" "this" {
  count               = local.create_vnet_panorama ? 1 : 0
  name                = var.name
  resource_group_name = local.resource_group_name
  location            = var.location
  panorama_base64_config = var.panorama_base64_config
  
  marketplace_offer_id = var.marketplace_offer_id
  plan_id             = var.plan_id
  tags                = var.tags

  network_profile {
    public_ip_address_ids   = var.public_ip_address_ids
    trusted_address_ranges  = var.trusted_address_ranges
    egress_nat_ip_address_ids = var.egress_nat_ip_address_ids

    vnet_configuration {
      virtual_network_id  = var.virtual_network_id
      trusted_subnet_id   = var.trusted_subnet_id
      untrusted_subnet_id = var.untrusted_subnet_id
    }
  }

  # DNS settings if specified
  dynamic "dns_settings" {
    for_each = var.dns_servers != null || var.use_azure_dns != null ? [1] : []
    content {
      dns_servers    = var.dns_servers
      use_azure_dns  = var.use_azure_dns
    }
  }

  # Destination NAT rules if specified
  dynamic "destination_nat" {
    for_each = var.destination_nat_rules
    content {
      name     = destination_nat.value.name
      protocol = destination_nat.value.protocol
      
      frontend_config {
        port                  = destination_nat.value.frontend_port
        public_ip_address_id  = destination_nat.value.frontend_public_ip_address_id
      }
      
      backend_config {
        port              = destination_nat.value.backend_port
        public_ip_address = destination_nat.value.backend_public_ip_address
      }
    }
  }
}

# Next Generation Firewall - Virtual Hub with Local Rulestack
resource "azurerm_palo_alto_next_generation_firewall_virtual_hub_local_rulestack" "this" {
  count               = local.create_vhub_local_rulestack ? 1 : 0
  name                = var.name
  resource_group_name = local.resource_group_name
  rulestack_id        = azurerm_palo_alto_local_rulestack.this[0].id
  
  marketplace_offer_id = var.marketplace_offer_id
  plan_id             = var.plan_id
  tags                = var.tags

  network_profile {
    public_ip_address_ids        = var.public_ip_address_ids
    trusted_address_ranges       = var.trusted_address_ranges
    egress_nat_ip_address_ids    = var.egress_nat_ip_address_ids
    virtual_hub_id               = var.virtual_hub_id
    network_virtual_appliance_id = azurerm_palo_alto_virtual_network_appliance.this[0].id
  }

  # DNS settings if specified
  dynamic "dns_settings" {
    for_each = var.dns_servers != null || var.use_azure_dns != null ? [1] : []
    content {
      dns_servers    = var.dns_servers
      use_azure_dns  = var.use_azure_dns
    }
  }

  # Destination NAT rules if specified
  dynamic "destination_nat" {
    for_each = var.destination_nat_rules
    content {
      name     = destination_nat.value.name
      protocol = destination_nat.value.protocol
      
      frontend_config {
        port                  = destination_nat.value.frontend_port
        public_ip_address_id  = destination_nat.value.frontend_public_ip_address_id
      }
      
      backend_config {
        port              = destination_nat.value.backend_port
        public_ip_address = destination_nat.value.backend_public_ip_address
      }
    }
  }
}

# Next Generation Firewall - Virtual Hub with Panorama
resource "azurerm_palo_alto_next_generation_firewall_virtual_hub_panorama" "this" {
  count               = local.create_vhub_panorama ? 1 : 0
  name                = var.name
  resource_group_name = local.resource_group_name
  location            = var.location
  panorama_base64_config = var.panorama_base64_config
  
  marketplace_offer_id = var.marketplace_offer_id
  plan_id             = var.plan_id
  tags                = var.tags

  network_profile {
    public_ip_address_ids        = var.public_ip_address_ids
    trusted_address_ranges       = var.trusted_address_ranges
    egress_nat_ip_address_ids    = var.egress_nat_ip_address_ids
    virtual_hub_id               = var.virtual_hub_id
    network_virtual_appliance_id = azurerm_palo_alto_virtual_network_appliance.this[0].id
  }

  # DNS settings if specified
  dynamic "dns_settings" {
    for_each = var.dns_servers != null || var.use_azure_dns != null ? [1] : []
    content {
      dns_servers    = var.dns_servers
      use_azure_dns  = var.use_azure_dns
    }
  }

  # Destination NAT rules if specified
  dynamic "destination_nat" {
    for_each = var.destination_nat_rules
    content {
      name     = destination_nat.value.name
      protocol = destination_nat.value.protocol
      
      frontend_config {
        port                  = destination_nat.value.frontend_port
        public_ip_address_id  = destination_nat.value.frontend_public_ip_address_id
      }
      
      backend_config {
        port              = destination_nat.value.backend_port
        public_ip_address = destination_nat.value.backend_public_ip_address
      }
    }
  }
}