module "availability_set" {
  source = "../availability_set"

  availability_set_data = local.availability_set_data

}