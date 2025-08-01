module "alarm_sns" {
  source        = "./modules/sns"
  topic_name    = var.topic_name
  subscriptions = var.subscriptions
  projectname = var.projectname
  owned_tags = var.owned_tags
}
