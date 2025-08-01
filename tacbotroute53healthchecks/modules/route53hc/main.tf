resource "aws_route53_health_check" "this" {
  fqdn              = var.fqdn
  port              = var.port
  type              = var.type
  resource_path     = var.resource_path
  failure_threshold = var.failure_threshold
  request_interval  = var.request_interval

  tags = merge(
    var.owned_tags,
    {
      Name = "${var.projectname}-route53-healthchecks"
    }
  )

  
}
