resource "azuread_user" "user" {
  for_each = { for key, value in var.user_data : key => value if value.enabled }

  # Required Arguments
  display_name        = each.value.display_name
  user_principal_name = each.value.user_principal_name


  lifecycle {
    prevent_destroy = false
  }
}
