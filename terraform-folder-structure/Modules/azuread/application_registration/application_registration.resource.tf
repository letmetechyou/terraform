resource "azuread_application_registration" "application_registration" {
  for_each = { for key, value in var.application_registration_data : key => value if value.enabled }

  # Required Arguments
  display_name = each.value.display_name


  # Required Blocks 



  # Optional Arguments
  description                            = each.value.description
  group_membership_claims                = each.value.group_membership_claims
  homepage_url                           = each.value.homepage_url
  implicit_access_token_issuance_enabled = each.value.implicit_access_token_issuance_enabled
  implicit_id_token_issuance_enabled     = each.value.implicit_id_token_issuance_enabled
  logout_url                             = each.value.logout_url
  marketing_url                          = each.value.marketing_url
  notes                                  = each.value.notes
  privacy_statement_url                  = each.value.privacy_statement_url
  requested_access_token_version         = each.value.requested_access_token_version
  service_management_reference           = each.value.service_management_reference
  sign_in_audience                       = each.value.sign_in_audience
  support_url                            = each.value.support_url
  terms_of_service_url                   = each.value.terms_of_service_url


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
