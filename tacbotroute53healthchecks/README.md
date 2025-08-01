# AWS Route 53 Health Check Terraform Module

## Overview

This Terraform module provisions one or more [AWS Route 53 Health Checks](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover.html) to monitor the availability and performance of endpoints.

It supports:

- Multiple health checks using `for_each`
- Configurable HTTP, HTTPS, or TCP checks
- Custom path, port, threshold, and interval
- Resource tagging
- Reusable structure for scalable deployments

---

## Resources Created

- `aws_route53_health_check`: Creates one health check per item in the input map.

---

## Module Inputs

| Variable Name         | Description                                              | Type    | Default | Example                        |
|----------------------|----------------------------------------------------------|---------|---------|--------------------------------|
| `fqdn`               | Fully qualified domain name to check                      | string  | —       | `"app.example.com"`            |
| `port`               | Port number to check (e.g., 80, 443)                      | number  | —       | `443`                          |
| `type`               | Type of check: `HTTP`, `HTTPS`, or `TCP`                 | string  | —       | `"HTTPS"`                      |
| `resource_path`      | Path to check (only for HTTP/HTTPS types)                | string  | `"/"`   | `"/health"`                    |
| `failure_threshold`  | Number of failed checks before considering unhealthy      | number  | `3`     | `2`                            |
| `request_interval`   | Interval (in seconds) between health checks               | number  | `30`    | `30`                           |
| `owned_tags`         | Common tags to apply to the health check resources        | map     | `{}`    | `{ Environment = "dev" }`      |
| `projectname`        | Name of the project for tagging and naming               | string  | —       | `"tacbot"`                     |

---

## Module Outputs

| Output Name               | Description                                    |
|---------------------------|------------------------------------------------|
| `route53_health_check_id` | The ID of the Route 53 Health Check created    |

---

## Root Module Example Usage

```hcl
module "route53_health_checks" {
  for_each = var.route53_health_checks

  source            = "./modules/route53hc"
  fqdn              = each.value.fqdn
  port              = each.value.port
  type              = each.value.type
  resource_path     = each.value.resource_path
  failure_threshold = each.value.failure_threshold
  request_interval  = each.value.request_interval
  owned_tags        = var.owned_tags
  projectname       = var.projectname
}


## terraform.tfvars

```hcl
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

