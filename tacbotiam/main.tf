module "iam_roles" {
  for_each     = var.iam_roles
  source       = "./modules/iam"
  role_config  = each.value
  owned_tags   = var.owned_tags
  projectname  = var.projectname
}
