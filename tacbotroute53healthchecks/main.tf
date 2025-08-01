module "route53_health_checks" {
  for_each = var.route53_health_checks

  source = "./modules/route53hc"

  fqdn              = each.value.fqdn
  port              = each.value.port
  type              = each.value.type
  resource_path     = each.value.resource_path
  failure_threshold = each.value.failure_threshold
  request_interval  = each.value.request_interval
  owned_tags = var.owned_tags
  projectname = var.projectname
}
