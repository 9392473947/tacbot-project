owned_tags = {
    Environment = "dev"
    Owner       = "chaithu"
    Project     = "tacbot"
    }
    projectname = "tacbot"

route53_health_checks = {
  app1 = {
    fqdn              = "app1.example.com"
    port              = 80
    type              = "HTTP"
    resource_path     = "/"
    failure_threshold = 3
    request_interval  = 30
  }

  app2 = {
    fqdn              = "app2.example.com"
    port              = 443
    type              = "HTTPS"
    resource_path     = "/health"
    failure_threshold = 2
    request_interval  = 30
    
  }
}
