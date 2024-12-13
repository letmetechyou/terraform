### USER MODULE
## Updated 05/02/2024 10:01:21

# USER_DATA.TFVARS EXAMPLE
```

```

# USER MAIN.TF MODULE REFERENCE
```
module "user" {
        source = "./modules//user"

        user_data = module._defaults.merge["user"]
}
```

# USER DEFAULTS TAGS.LOCAL.TF
```
user = false
```

# USER DEFAULTS DEFAULTS_MERGE.LOCAL.TF
```
user = { for k, v in var.user_data : k => merge(v, try(local.tags_used["user"], false) ? { tags = merge(var.global_defaults.tags, var.environment_defaults.tags, v.tags) } : {}) }
```

# USER DEFAULTS DEFAULTS.VARIABLES.TF
```
variable "user_data" { default = {} }
```

# USER ROOT VARIABLES.TF
```

```
