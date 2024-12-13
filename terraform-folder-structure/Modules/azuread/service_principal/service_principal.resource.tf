resource "azuread_service_principal" "service_principal" {
  for_each = { for key, value in var.service_principal_data : key => value if value.enabled }

  # Required Arguments
  client_id = coalesce(
    try(each.value.client_id, null),
    try(var.application_registration_output["${each.value.app_registration_name}"].client_id, null)
  )


  # Required Blocks 



  # Optional Arguments
  account_enabled               = each.value.account_enabled
  alternative_names             = each.value.alternative_names
  app_role_assignment_required  = each.value.app_role_assignment_required
  description                   = each.value.description
  login_url                     = each.value.login_url
  notes                         = each.value.notes
  notification_email_addresses  = each.value.notification_email_addresses
  owners                        = each.value.owners
  preferred_single_sign_on_mode = each.value.preferred_single_sign_on_mode
  tags                          = each.value.tags
  use_existing                  = each.value.use_existing


  # Optional Dynamic Blocks
  dynamic "feature_tags" {

    for_each = each.value.feature_tags != null ? [1] : []

    content {
      # Required

      # Optional
      custom_single_sign_on = each.value.feature_tags.custom_single_sign_on
      enterprise            = each.value.feature_tags.enterprise
      gallery               = each.value.feature_tags.gallery
      hide                  = each.value.feature_tags.hide
    }
  }

  dynamic "saml_single_sign_on" {

    for_each = each.value.saml_single_sign_on != null ? range(length(each.value.saml_single_sign_on)) : []

    content {
      # Required

      # Optional
      relay_state = each.value.saml_single_sign_on[saml_single_sign_on.key].relay_state
    }
  }


  lifecycle {
    prevent_destroy = false
  }
}
