resource "tls_private_key" "tls_private_key" {
  for_each = { for key, value in var.tls_private_key_data : coalesce(try(value.name, null), try(key, null)) => value if value.enabled }

  # Required
  algorithm = each.value.algorithm

  # Optional
  ecdsa_curve = each.value.ecdsa_curve
  rsa_bits    = each.value.rsa_bits
}
