### APPLICATION_PASSWORD MODULE
## Updated 03/15/2024 17:15:38

# APPLICATION_PASSWORD_DATA.TFVARS EXAMPLE
```
application_password_data = {
  example-password = {
    enabled             = true
    application_id      = "abcdef01-2345-6789-abcd-ef0123456789"
    display_name        = "Example Password"
    end_date_relative   = "P90D"  # 90 days relative to creation time
    rotate_when_changed = true
    start_date          = "2024-01-01T00:00:00Z"  # Start date for the password validity
  }
}
```

# APPLICATION_PASSWORD MAIN.TF MODULE REFERENCE
```
module "application_password" {
        source = "./.terraform/modules/_default/application_password"

        application_password_data = module._defaults.merge["application_password"]
        application_registration_output = module.application_registration.application_registration_output_names
}
```

# APPLICATION_PASSWORD DEFAULTS TAGS.LOCAL.TF
```
application_password = false
```

# APPLICATION_PASSWORD DEFAULTS DEFAULTS_MERGE.LOCAL.TF
```
application_password = { for k, v in var.application_password_data : k => merge(v, try(local.tags_used["application_password"], false) ? { tags = merge(var.global_defaults.tags, var.environment_defaults.tags, v.tags) } : {}) }
```

# APPLICATION_PASSWORD DEFAULTS DEFAULTS.VARIABLES.TF
```
variable "application_password_data" { default = {} }
```

# APPLICATION_PASSWORD ROOT VARIABLES.TF
```
variable "application_password_data" {
  type = map(object({
    # Required
    enabled       = bool
    application_id = optional(string)
    application_name = optional(string)

    # Optional
    display_name        = optional(string)
    end_date_relative   = optional(string)
    end_date            = optional(string)
    rotate_when_changed = optional(map(string))
    start_date          = optional(string)
  }))
  default = {}
}
```
