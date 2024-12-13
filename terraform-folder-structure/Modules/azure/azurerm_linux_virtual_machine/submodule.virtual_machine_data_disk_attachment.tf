module "virtual_machine_data_disk_attachment" {
  source = "../virtual_machine_data_disk_attachment"

  virtual_machine_data_disk_attachment_data = local.virtual_machine_data_disk_attachment_data
  virtual_machine_output                    = local.linux_virtual_machine_output
  managed_disk_output                       = module.managed_disk.managed_disk_output_names
}