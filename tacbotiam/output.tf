output "iam_role_arns" {
  description = "ARNs of all created IAM roles"
  value = {
    for role_key, mod in module.iam_roles : role_key => mod.role_arn
  }
}

output "iam_role_names" {
  description = "Names of all created IAM roles"
  value = {
    for role_key, mod in module.iam_roles : role_key => mod.role_name
  }
}
