output "mssql_database_output" {
  value = zipmap(values(azurerm_mssql_database.mssql_database)[*].name, values(azurerm_mssql_database.mssql_database)[*])
}

output "mssql_database_output_names" {
  value = { for key, value in azurerm_mssql_database.mssql_database : value.name => value }
}
