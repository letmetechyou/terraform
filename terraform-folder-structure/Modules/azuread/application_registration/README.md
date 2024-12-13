### APPLICATION_REGISTRATION MODULE
## Updated 03/15/2024 15:18:16

# APPLICATION_REGISTRATION_DATA.TFVARS EXAMPLE
```
application_registration_data = {
  example-registration = {
    enabled                               = true
    display_name                          = "Example Application"
    description                           = "This is an example application registration"
    group_membership_claims               = "SecurityGroup"
    homepage_url                          = "https://example.com"
    implicit_access_token_issuance_enabled = true
    implicit_id_token_issuance_enabled     = true
    logout_url                            = "https://example.com/logout"
    marketing_url                         = "https://example.com/marketing"
    notes                                 = "Additional notes about the application"
    privacy_statement_url                 = "https://example.com/privacy"
    requested_access_token_version        = "2"
    service_management_reference          = "ServiceXYZ"
    sign_in_audience                      = "AzureADandPersonalMicrosoftAccount"
    support_url                           = "https://example.com/support"
    terms_of_service_url                  = "https://example.com/terms"
  }
}
```

# APPLICATION_REGISTRATION MAIN.TF MODULE REFERENCE
```
module "application_registration" {
        source = "./.terraform/modules/_default/application_registration"

        application_registration_data = module._defaults.merge["application_registration"]
}
```

# APPLICATION_REGISTRATION DEFAULTS TAGS.LOCAL.TF
```
application_registration = false
```

# APPLICATION_REGISTRATION DEFAULTS DEFAULTS_MERGE.LOCAL.TF
```
application_registration = { for k, v in var.application_registration_data : k => merge(v, try(local.tags_used["application_registration"], false) ? { tags = merge(var.global_defaults.tags, var.environment_defaults.tags, v.tags) } : {}) }
```

# APPLICATION_REGISTRATION DEFAULTS DEFAULTS.VARIABLES.TF
```
variable "application_registration_data" { default = {} }
```

# APPLICATION_REGISTRATION ROOT VARIABLES.TF
```
variable "application_registration_data" {
  type = map(object({
    # Required
    enabled      = bool
    display_name = string

    # Optional
    description                            = optional(string)
    group_membership_claims                = optional(list(string))
    homepage_url                           = optional(string)
    implicit_access_token_issuance_enabled = optional(bool)
    implicit_id_token_issuance_enabled     = optional(bool)
    logout_url                             = optional(string)
    marketing_url                          = optional(string)
    notes                                  = optional(string)
    privacy_statement_url                  = optional(string)
    requested_access_token_version         = optional(string)
    service_management_reference           = optional(string)
    sign_in_audience                       = optional(string)
    support_url                            = optional(string)
    terms_of_service_url                   = optional(string)
  }))
  default = {}
}
```
