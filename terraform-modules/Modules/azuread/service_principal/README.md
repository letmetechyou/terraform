### SERVICE_PRINCIPAL MODULE
## Updated 03/18/2024 19:35:09

# SERVICE_PRINCIPAL_DATA.TFVARS EXAMPLE
```
service_principal_data = {
  example-service-principal = {
    enabled           = true
    client_id         = "abcdef01-2345-6789-abcd-ef0123456789"
    account_enabled   = true
    description       = "Example Service Principal"
    notification_email_addresses = ["admin@example.com"]
    tags = {
      Environment = "Production"
    }
    feature_tags = {
      feature1 = {
        enterprise = true
        gallery    = false
      }
      feature2 = {
        hide = true
      }
    }
    saml_single_sign_on = {
      saml1 = {
        relay_state = "example-relay-state"
      }
    }
  }
}
```

# SERVICE_PRINCIPAL MAIN.TF MODULE REFERENCE
```
module "service_principal" {
        source = "./modules/azuread/service_principal"

        service_principal_data = module._defaults.merge["service_principal"]
}
```

# SERVICE_PRINCIPAL DEFAULTS TAGS.LOCAL.TF
```
service_principal = false
```

# SERVICE_PRINCIPAL DEFAULTS DEFAULTS_MERGE.LOCAL.TF
```
service_principal = { for k, v in var.service_principal_data : k => merge(v, try(local.tags_used["service_principal"], false) ? { tags = merge(var.global_defaults.tags, var.environment_defaults.tags, v.tags) } : {}) }
```

# SERVICE_PRINCIPAL DEFAULTS DEFAULTS.VARIABLES.TF
```
variable "service_principal_data" { default = {} }
```

# SERVICE_PRINCIPAL ROOT VARIABLES.TF
```
variable "service_principal_data" {
  type = map(object({
    # Required
    enabled   = bool
    client_id = optional(string)
    app_registration_name = optional(string)

    # Optional
    account_enabled               = optional(bool)
    alternative_names             = optional(list(string))
    app_role_assignment_required  = optional(bool)
    description                   = optional(string)
    login_url                     = optional(string)
    notes                         = optional(string)
    notification_email_addresses  = optional(list(string))
    owners                        = optional(list(string))
    preferred_single_sign_on_mode = optional(string)
    tags                          = optional(list(string))
    use_existing                  = optional(bool)

    # Optional Dynamic Blocks
    feature_tags = optional(object({
      custom_single_sign_on = optional(bool)
      enterprise            = optional(bool)
      gallery               = optional(bool)
      hide                  = optional(bool)
    }))
    saml_single_sign_on = optional(object({
      relay_state = optional(string)
    }))
  }))
  default = {}
}
```
