# Used for checking if tags are allowed
output "tags_allowed" {
  value = { for k, v in local.tags_used : k => v }
}

#Used for Testing
output "tags_merged" {
  value = merge(var.global_defaults.tags, var.environment_defaults.tags)
}


#This is used for modules
output "merge" {
  value = { for k, v in local.defaults_merge : k => v }
}