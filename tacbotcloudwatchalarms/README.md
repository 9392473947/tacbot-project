# CloudWatch Alarms Terraform Module Documentation

## Overview

This Terraform module provisions one or more AWS CloudWatch Metric Alarms with customizable parameters such as metric, namespace, thresholds, evaluation periods, and alarm actions.

---

## Resources Created

### CloudWatch Metric Alarms

- Creates metric alarms based on the configuration map input.
- Supports dynamic alarms creation using `for_each`.
- Configurable with parameters like metric name, namespace, threshold, comparison operators, evaluation periods, and alarm actions (e.g., SNS topic ARN).
- Supports custom dimensions to scope alarms to specific AWS resources.

---

## Module Inputs

| Variable Name | Description                     | Type                                         | Example                                                      |
|---------------|---------------------------------|----------------------------------------------|--------------------------------------------------------------|
| `alarms`      | Map of CloudWatch alarm configs | `map(object)`                                | See example below                                            |

Each alarm object supports the following keys:

| Field               | Description                                      | Type          | Example                                     |
|---------------------|-------------------------------------------------|---------------|---------------------------------------------|
| `alarm_name`        | Name of the CloudWatch alarm                     | `string`      | `"HighCPUUtilization"`                      |
| `comparison_operator` | Comparison operator for the metric threshold   | `string`      | `"GreaterThanThreshold"`                    |
| `evaluation_periods` | Number of evaluation periods                     | `number`      | `2`                                         |
| `metric_name`       | Name of the metric                               | `string`      | `"CPUUtilization"`                          |
| `namespace`         | Metric namespace                                | `string`      | `"AWS/EC2"`                                 |
| `period`            | Granularity of the metric data in seconds       | `number`      | `120`                                       |
| `statistic`         | Statistic to apply (Average, Sum, Minimum, etc.)| `string`      | `"Average"`                                 |
| `threshold`         | Threshold value to trigger alarm                 | `number`      | `80`                                        |
| `alarm_description` | Description of the alarm                          | `string`      | `"This alarm triggers when CPU is over 80%"` |
| `alarm_actions`     | List of ARNs to notify when alarm triggers       | `list(string)`| `["arn:aws:sns:ap-south-1:123456789012:topic"]` |
| `dimensions`       | Map of dimensions to filter metric data          | `map(string)` | `{ InstanceId = "i-1234567890abcdef0" }`  |

---

## Module Outputs

| Output Name          | Description                        |
|----------------------|----------------------------------|
| `cloudwatch_alarm_names` | Map of alarm keys to their names |

---

## Example Usage (Root Module)

```hcl
provider "aws" {
  region = "ap-south-1"
}

module "cloudwatch_alarms" {
  source = "./modules/cloudwatchalarms"

  alarms = var.alarms
}

output "all_alarm_names" {
  value = module.cloudwatch_alarms.cloudwatch_alarm_names
}


## Example `terraform.tfvars`

```hcl
alarms = {
  high_cpu_alarm = {
    alarm_name          = "HighCPUUtilization"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods  = 2
    metric_name         = "CPUUtilization"
    namespace           = "AWS/EC2"
    period              = 120
    statistic           = "Average"
    threshold           = 80
    alarm_description   = "This alarm triggers when CPU is over 80%"
    alarm_actions       = ["arn:aws:sns:ap-south-1:992382670521:cloudwatch-alarm-topic"]
    dimensions          = {
      InstanceId = "i-1234567890abcdef0"
    }
  }

  route53_health_check_alarm = {
    alarm_name          = "Route53-HealthCheck-Alarm"
    comparison_operator = "LessThanThreshold"
    evaluation_periods  = 2
    metric_name         = "HealthCheckStatus"
    namespace           = "AWS/Route53"
    period              = 60
    statistic           = "Minimum"
    threshold           = 1
    alarm_description   = "Alarm when Route53 health check fails"
    alarm_actions       = ["arn:aws:sns:ap-south-1:992382670521:cloudwatch-alarm-topic"]
    dimensions          = {
      HealthCheckId = "31386e79-3fcb-44c6-9057-64397b608011"
    }
  }
}

