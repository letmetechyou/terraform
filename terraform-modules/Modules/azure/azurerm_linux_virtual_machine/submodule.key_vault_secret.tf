module "key_vault_secret" {
  source = "../key_vault_secret"

  key_vault_secret_data  = local.tls_private_key_data
  tls_private_key_output = module.tls_private_key.tls_private_key_output
}
