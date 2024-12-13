resource "azuread_application_password" "application_password" {
  for_each = { for key, value in var.application_password_data : key => value if value.enabled }

  # Required Arguments
  application_id = coalesce(
    try(each.value.application_id, null),
    try(var.application_registration_output["${each.value.application_name}"].id, null)
  )


  # Required Blocks 



  # Optional Arguments
  display_name        = each.value.display_name
  end_date_relative   = each.value.end_date_relative
  end_date            = each.value.end_date
  rotate_when_changed = each.value.rotate_when_changed
  start_date          = each.value.start_date


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
