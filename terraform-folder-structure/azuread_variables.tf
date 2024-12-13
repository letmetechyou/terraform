variable "application_password_data" {
  type = map(object({
    # Required
    enabled          = bool
    application_id   = optional(string)
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

variable "service_principal_data" {
  type = map(object({
    # Required
    enabled               = bool
    client_id             = optional(string)
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

variable "user_data" {
  type = map(object({
    display_name        = string
    user_principal_name = string
  }))
  default = {}
}
