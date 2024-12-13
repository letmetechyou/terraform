### GROUP MODULE
## Updated 04/11/2024 17:01:24

# GROUP_DATA.TFVARS EXAMPLE
```
group_data = {
  example-group = {
    enabled      = true
    display_name = "Example Group"

    administrative_unit_ids    = ["admin-unit-1", "admin-unit-2"]
    assignable_to_role         = true
    auto_subscribe_new_members = true
    behaviors                  = ["behavior1", "behavior2"]
    description                = "Example group description"
    external_senders_allowed   = true
    hide_from_address_lists    = false
    hide_from_outlook_clients  = false
    mail_enabled               = true
    mail_nickname              = "examplegroup"
    members                    = ["user1@example.com", "user2@example.com"]
    onpremises_group_type      = "security"
    owners                     = ["owner1@example.com", "owner2@example.com"]
    prevent_duplicate_names    = true
    provisioning_options       = ["option1", "option2"]
    security_enabled           = true
    theme                      = "default"
    types                      = ["type1", "type2"]
    visibility                 = "private"
    writeback_enabled          = true

    dynamic_membership = {
      enabled = true
      rule    = "user.department -contains 'IT'"
    }
  }
}
```

# GROUP MAIN.TF MODULE REFERENCE
```
module "group" {
        source = "./modules/azuread/group"

        group_data = module._defaults.merge["group"]
}
```

# GROUP DEFAULTS TAGS.LOCAL.TF
```
group = false
```

# GROUP DEFAULTS DEFAULTS_MERGE.LOCAL.TF
```
group = { for k, v in var.group_data : k => merge(v, try(local.tags_used["group"], false) ? { tags = merge(var.global_defaults.tags, var.environment_defaults.tags, v.tags) } : {}) }
```

# GROUP DEFAULTS DEFAULTS.VARIABLES.TF
```
variable "group_data" { default = {} }
```

# GROUP ROOT VARIABLES.TF
```
variable "group_data" {
  type = map(object({
    # Required
    enabled      = bool
    display_name = string

    # Optional
    administrative_unit_ids    = optional(list(string))
    assignable_to_role         = optional(bool)
    auto_subscribe_new_members = optional(bool)
    behaviors                  = optional(list(string))
    description                = optional(string)
    external_senders_allowed   = optional(bool)
    hide_from_address_lists    = optional(bool)
    hide_from_outlook_clients  = optional(bool)
    mail_enabled               = optional(bool)
    mail_nickname              = optional(string)
    members                    = optional(list(string))
    onpremises_group_type      = optional(string)
    owners                     = optional(list(string))
    prevent_duplicate_names    = optional(bool)
    provisioning_options       = optional(list(string))
    security_enabled           = optional(bool)
    theme                      = optional(string)
    types                      = optional(list(string))
    visibility                 = optional(string)
    writeback_enabled          = optional(bool)

    # Optional Dynamic Blocks
    dynamic_membership = optional(object({
      enabled = bool
      rule    = string
    }))
  }))
  default = {}
}
```
