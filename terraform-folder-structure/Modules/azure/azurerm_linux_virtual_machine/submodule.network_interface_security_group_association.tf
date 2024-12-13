module "network_interface_security_group_association" {
  source = "../network_interface_security_group_association"

  network_interface_security_group_association_data = local.network_interface_security_group_association_data
  network_interface_output                          = module.network_interface.network_interface_output_names
  network_security_group_output                     = var.network_security_group_output
}
