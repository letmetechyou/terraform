module "managed_disk" {
  source = "../managed_disk"

  managed_disk_data = local.managed_disk_data
}
