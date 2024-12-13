module "tls_private_key" {
  source = "../tls_private_key"

  tls_private_key_data = local.tls_private_key_data
}
