module "ecr" {
  source                 = "./modules/ecr"
  name                   = var.repo_name
  lifecycle_policy       = file("${path.module}/lifecycle.json")
  kms_key_arn             = var.kms_key_arn  # or file("kms_policy.json")
  owned_tags = var.owned_tags
  projectname = var.projectname
}
