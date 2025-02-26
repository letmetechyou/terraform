resource "azuread_group" "group" {
  for_each = { for key, value in var.group_data : key => value if value.enabled }

  # Required Arguments
  display_name = each.value.display_name


  # Required Blocks 



  # Optional Arguments
  administrative_unit_ids    = each.value.administrative_unit_ids
  assignable_to_role         = each.value.assignable_to_role
  auto_subscribe_new_members = each.value.auto_subscribe_new_members
  behaviors                  = each.value.behaviors
  description                = each.value.description
  external_senders_allowed   = each.value.external_senders_allowed
  hide_from_address_lists    = each.value.hide_from_address_lists
  hide_from_outlook_clients  = each.value.hide_from_outlook_clients
  mail_enabled               = each.value.mail_enabled
  mail_nickname              = each.value.mail_nickname
  members                    = each.value.members
  onpremises_group_type      = each.value.onpremises_group_type
  owners                     = each.value.owners
  prevent_duplicate_names    = each.value.prevent_duplicate_names
  provisioning_options       = each.value.provisioning_options
  security_enabled           = each.value.security_enabled
  theme                      = each.value.theme
  types                      = each.value.types
  visibility                 = each.value.visibility
  writeback_enabled          = each.value.writeback_enabled


  # Optional Dynamic Blocks

  dynamic "dynamic_membership" {

    for_each = each.value.dynamic_membership != null ? [1] : []

    content {
      # Required
      enabled = each.value.dynamic_membership.enabled
      rule    = each.value.dynamic_membership.rule

      # Optional
    }
  }


  lifecycle {
    prevent_destroy = false
  }
}
