module "secret" {
  source = "./modules/secret"
  secret_name = var.secret_name
  secret_description = var.secret_description
  secret_data = var.secret_data
  owned_tags = var.owned_tags
  projectname = var.projectname
  kms_key_id   = var.kms_key_id
}