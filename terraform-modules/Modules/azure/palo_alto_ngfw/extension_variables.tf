# extension_variables.tf
# Variables for the Local Rulestack Extension

# FQDN Lists
variable "fqdn_lists" {
  description = "Map of FQDN lists to create for the local rulestack"
  type = map(object({
    fqdns          = list(string)
    description    = optional(string)
    audit_comment  = optional(string)
  }))
  default = {}
}

# Prefix Lists
variable "prefix_lists" {
  description = "Map of prefix lists to create for the local rulestack"
  type = map(object({
    prefixes       = list(string)
    description    = optional(string)
    audit_comment  = optional(string)
  }))
  default = {}
}

# Certificates
variable "certificates" {
  description = "Map of certificates to create for the local rulestack"
  type = map(object({
    self_signed              = optional(bool, false)
    key_vault_certificate_id = optional(string)
    description              = optional(string)
    audit_comment            = optional(string)
  }))
  default = {}
  
  validation {
    condition = alltrue([
      for cert in var.certificates : (cert.self_signed == true && cert.key_vault_certificate_id == null) || 
                                     (cert.self_signed == false && cert.key_vault_certificate_id != null)
    ])
    error_message = "For each certificate, exactly one of self_signed or key_vault_certificate_id must be specified."
  }
}

# Certificate Associations
variable "outbound_trust_certificate_name" {
  description = "Name of the certificate to use as the outbound trust certificate"
  type        = string
  default     = null
}

variable "outbound_untrust_certificate_name" {
  description = "Name of the certificate to use as the outbound untrust certificate"
  type        = string
  default     = null
}

# Rules
variable "rules" {
  description = "Map of rules to create for the local rulestack"
  type = map(object({
    priority            = number
    action              = string
    applications        = list(string)
    protocol            = optional(string)
    protocol_ports      = optional(list(string))
    description         = optional(string)
    enabled             = optional(bool)
    audit_comment       = optional(string)
    logging_enabled     = optional(bool)
    negate_source       = optional(bool)
    negate_destination  = optional(bool)
    decryption_rule_type = optional(string)
    inspection_certificate_id = optional(string)
    
    source = object({
      cidrs                          = optional(list(string))
      countries                      = optional(list(string))
      feeds                          = optional(list(string))
      local_rulestack_prefix_list_ids = optional(list(string))
    })
    
    destination = object({
      cidrs                          = optional(list(string))
      countries                      = optional(list(string))
      feeds                          = optional(list(string))
      local_rulestack_prefix_list_ids = optional(list(string))
      local_rulestack_fqdn_list_ids   = optional(list(string))
    })
    
    category = optional(object({
      feeds       = optional(list(string))
      custom_urls = optional(list(string))
    }))
  }))
  default = {}
}