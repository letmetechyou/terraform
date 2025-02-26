module "application_password" {
  source = "./modules/hashicorp/azuread/application_password"

  application_password_data       = var.application_password_data
  application_registration_output = module.application_registration.application_registration_output_names
}

module "application_registration" {
  source = "./modules/hashicorp/azuread/application_registration"

  application_registration_data = var.application_registration_data
}

module "group" {
  source = "./modules/hashicorp/azuread/group"

  group_data = var.group_data
}

module "service_principal" {
  source = "./modules/hashicorp/azuread/service_principal"

  service_principal_data          = var.service_principal_data
  application_registration_output = module.application_registration.application_registration_output_names
}

module "user" {
  source = "./modules/hashicorp/azuread/user"

  user_data = var.user_data
}
