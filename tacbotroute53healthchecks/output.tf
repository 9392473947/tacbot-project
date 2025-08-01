output "health_check_ids" {
  value = {
    for k, hc in module.route53_health_checks : k => hc.route53_health_check_id
  }
}
