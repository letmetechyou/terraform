# variables.tf
# Module variables for the Palo Alto Firewall Module

# Core Variables
variable "firewall_type" {
  description = "Type of Palo Alto firewall to deploy. Valid options: vnet_local_rulestack, vnet_panorama, vhub_local_rulestack, vhub_panorama"
  type        = string
  validation {
    condition     = contains(["vnet_local_rulestack", "vnet_panorama", "vhub_local_rulestack", "vhub_panorama"], lower(var.firewall_type))
    error_message = "Valid values for firewall_type are: vnet_local_rulestack, vnet_panorama, vhub_local_rulestack, vhub_panorama"
  }
}

variable "name" {
  description = "Name of the Palo Alto firewall"
  type        = string
}

variable "create_resource_group" {
  description = "Whether to create a resource group for the firewall"
  type        = bool
  default     = false
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region where the firewall will be deployed"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all created resources"
  type        = map(string)
  default     = {}
}

# Marketplace & Plan Variables
variable "marketplace_offer_id" {
  description = "The marketplace offer ID"
  type        = string
  default     = "pan_swfw_cloud_ngfw"
}

variable "plan_id" {
  description = "The billing plan ID as published by Liftr.PAN"
  type        = string
  default     = "panw-cngfw-payg"
}

# Local Rulestack Variables
variable "local_rulestack_name" {
  description = "Name of the local rulestack (if null, will use firewall name + -rulestack)"
  type        = string
  default     = null
}

variable "local_rulestack_description" {
  description = "Description for the local rulestack"
  type        = string
  default     = null
}

variable "anti_spyware_profile" {
  description = "The setting to use for Anti-Spyware. Possible values include BestPractice, and Custom."
  type        = string
  default     = "BestPractice"
}

variable "anti_virus_profile" {
  description = "The setting to use for Anti-Virus. Possible values include BestPractice, and Custom."
  type        = string
  default     = "BestPractice"
}

variable "dns_subscription" {
  description = "The setting to use for DNS Subscription. Possible values include BestPractice, and Custom."
  type        = string
  default     = "BestPractice"
}

variable "file_blocking_profile" {
  description = "The setting to use for the File Blocking Profile. Possible values include BestPractice, and Custom."
  type        = string
  default     = "BestPractice"
}

variable "url_filtering_profile" {
  description = "The setting to use for the URL Filtering Profile. Possible values include BestPractice, and Custom."
  type        = string
  default     = "BestPractice"
}

variable "vulnerability_profile" {
  description = "The setting to use for the Vulnerability Profile. Possible values include BestPractice, and Custom."
  type        = string
  default     = "BestPractice"
}

# Virtual Network Appliance Variables
variable "virtual_network_appliance_name" {
  description = "Name of the virtual network appliance (if null, will use firewall name + -vna)"
  type        = string
  default     = null
}

# Panorama Variables
variable "panorama_base64_config" {
  description = "The Base64 Encoded configuration value for connecting to the Panorama Configuration server"
  type        = string
  default     = null
}

# Network Variables - Common
variable "public_ip_address_ids" {
  description = "List of public IP address IDs to use for the firewall"
  type        = list(string)
  default     = []
}

variable "egress_nat_ip_address_ids" {
  description = "List of public IP address IDs to use for egress NAT"
  type        = list(string)
  default     = []
}

variable "trusted_address_ranges" {
  description = "List of trusted IP address ranges"
  type        = list(string)
  default     = null
}

# Network Variables - Virtual Network
variable "virtual_network_id" {
  description = "ID of the virtual network for VNet deployments"
  type        = string
  default     = null
}

variable "trusted_subnet_id" {
  description = "ID of the trusted subnet for VNet deployments"
  type        = string
  default     = null
}

variable "untrusted_subnet_id" {
  description = "ID of the untrusted subnet for VNet deployments"
  type        = string
  default     = null
}

# Network Variables - Virtual Hub
variable "virtual_hub_id" {
  description = "ID of the virtual hub for VHub deployments"
  type        = string
  default     = null
}

# DNS Settings
variable "dns_servers" {
  description = "List of DNS servers to use"
  type        = list(string)
  default     = null
}

variable "use_azure_dns" {
  description = "Whether to use Azure DNS servers"
  type        = bool
  default     = null
}

# Destination NAT Rules
variable "destination_nat_rules" {
  description = "List of destination NAT rules to create"
  type = list(object({
    name                        = string
    protocol                    = string
    frontend_port               = number
    frontend_public_ip_address_id = string
    backend_port                = number
    backend_public_ip_address   = string
  }))
  default = []
}