module "kms" {
  source                  = "./modules/kms"
  description             = "Customer managed key for secrets"
  alias                   = "secrets-key"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  owned_tags = var.owned_tags
  projectname = var.projectname
}