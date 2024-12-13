module "network_interface" {
  source = "../network_interface"

  network_interface_data = local.network_interface_data
}