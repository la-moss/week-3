output "primary_resource_group_name" {
  value = module.iam_primary.resource_group_name
}

output "secondary_resource_group_name" {
  value = module.iam_secondary.resource_group_name
}

output "primary_role_definition_id" {
  value = module.iam_primary.role_definition_id
}

output "secondary_role_definition_id" {
  value = module.iam_secondary.role_definition_id
}
