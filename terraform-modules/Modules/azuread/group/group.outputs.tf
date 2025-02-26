output "group_output" {
  value = zipmap(values(azuread_group.group)[*].name, values(azuread_group.group)[*])
}

output "group_output_names" {
  value = { for key, value in azuread_group.group : value.name => value }
}
