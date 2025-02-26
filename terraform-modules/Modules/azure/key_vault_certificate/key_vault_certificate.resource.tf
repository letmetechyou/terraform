resource "azurerm_key_vault_certificate" "key_vault_certificate" {
  for_each = { for key, value in var.key_vault_certificate_data : key => value if value.enabled }

  # Required Arguments
  name         = each.value.name
  key_vault_id = each.value.key_vault_id #update to use key vault name using coalesce

  # Optional Arguments
  tags = each.value.tags

  # Dynamic Blocks
  dynamic "certificate" {
    for_each = each.value.certificate != null ? [1] : []
    content {
      contents = each.value.certificate.contents
      password = each.value.certificate.password
    }
  }

  dynamic "certificate_policy" {
    for_each = each.value.certificate_policy != null ? [1] : []
    content {
      dynamic "issuer_parameters" {
        for_each = each.value.certificate_policy.issuer_parameters != null ? [1] : []
        content {
          name = each.value.certificate_policy.issuer_parameters.name
        }
      }
      dynamic "key_properties" {
        for_each = each.value.certificate_policy.key_properties != null ? [1] : []
        content {
          curve      = each.value.certificate_policy.key_properties.curve
          exportable = each.value.certificate_policy.key_properties.exportable
          key_size   = each.value.certificate_policy.key_properties.key_size
          key_type   = each.value.certificate_policy.key_properties.key_type
          reuse_key  = each.value.certificate_policy.key_properties.reuse_key
        }
      }
      dynamic "lifetime_action" {
        for_each = each.value.certificate_policy.lifetime_action != null ? [1] : []
        content {
          dynamic "action" {
            for_each = each.value.certificate_policy.lifetime_action.action != null ? [1] : []
            content {
              action_type = each.value.certificate_policy.lifetime_action.action.action_type
            }
          }
          dynamic "trigger" {
            for_each = each.value.certificate_policy.lifetime_action.trigger != null ? [1] : []
            content {
              days_before_expiry  = each.value.certificate_policy.lifetime_action.trigger.days_before_expiry
              lifetime_percentage = each.value.certificate_policy.lifetime_action.trigger.lifetime_percentage
            }
          }
        }
      }
      dynamic "secret_properties" {
        for_each = each.value.certificate_policy.secret_properties != null ? [1] : []
        content {
          content_type = each.value.certificate_policy.secret_properties.content_type
        }
      }
      dynamic "x509_certificate_properties" {
        for_each = each.value.certificate_policy.x509_certificate_properties != null ? [1] : []
        content {
          extended_key_usage = each.value.certificate_policy.x509_certificate_properties.extended_key_usage
          key_usage          = each.value.certificate_policy.x509_certificate_properties.key_usage
          subject            = each.value.certificate_policy.x509_certificate_properties.subject
          validity_in_months = each.value.certificate_policy.x509_certificate_properties.validity_in_months

          dynamic "subject_alternative_names" {
            for_each = each.value.certificate_policy.x509_certificate_properties.subject_alternative_names != null ? [1] : []
            content {
              dns_names = each.value.certificate_policy.x509_certificate_properties.subject_alternative_names.dns_names
              emails    = each.value.certificate_policy.x509_certificate_properties.subject_alternative_names.emails
              upns      = each.value.certificate_policy.x509_certificate_properties.subject_alternative_names.upns
            }
          }
        }
      }
    }
  }

  lifecycle {
    prevent_destroy = false
  }
}
