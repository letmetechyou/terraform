module "virtual_machine_extension" {
  source = "../virtual_machine_extension"

  virtual_machine_extension_data = local.virtual_machine_extension_data
  virtual_machine_output         = local.linux_virtual_machine_output

  depends_on = [
    azurerm_linux_virtual_machine.linux_virtual_machine,
    module.availability_set,
    module.network_interface,
    module.managed_disk,
  ]
}
