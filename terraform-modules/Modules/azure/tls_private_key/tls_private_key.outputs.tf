output "tls_private_key_output" {
  value = { for key, value in tls_private_key.tls_private_key : key => value }
}
