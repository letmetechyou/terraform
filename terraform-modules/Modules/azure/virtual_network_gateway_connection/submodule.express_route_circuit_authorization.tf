module "express_route_circuit_authorization" {
  source = "../express_route_circuit_authorization"

  providers = {
    azurerm = azurerm.Cloud_Services
  }

  express_route_circuit_authorization_data = var.express_route_circuit_authorization_data

}
