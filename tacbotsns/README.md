# AWS SNS Terraform Module

## Overview

This Terraform module provisions an Amazon SNS topic and subscribes a list of email endpoints to that topic.  
It is commonly used for sending CloudWatch Alarm notifications or other event-driven alerts via email.

---

## Resources Created

- `aws_sns_topic`: Creates an SNS topic.
- `aws_sns_topic_subscription`: Subscribes one or more email addresses to the topic.

---

## Module Inputs

| Variable Name   | Description                                | Type           | Example                                                      |
|------------------|--------------------------------------------|----------------|--------------------------------------------------------------|
| `topic_name`     | Name for the SNS topic                     | `string`       | `"cloudwatch-alarm-topic"`                                   |
| `subscriptions`  | List of email addresses to subscribe       | `list(string)` | `["admin@example.com", "ops@example.com"]`                   |
| `owned_tags`     | Tags to apply to all resources             | `map(string)`  | `{ Environment = "dev", Owner = "chaithu" }`                 |
| `projectname`    | Project prefix for naming resources        | `string`       | `"tacbot"`                                                   |

---

## Module Outputs

| Output Name     | Description             |
|------------------|-------------------------|
| `sns_topic_arn`  | ARN of the SNS topic    |

---

## Example Usage

```hcl
module "alarm_sns" {
  source        = "./modules/sns"
  topic_name    = var.topic_name
  subscriptions = var.subscriptions
  projectname   = var.projectname
  owned_tags    = var.owned_tags
}

## terraform.tfvars

projectname = "tacbot"
topic_name  = "cloudwatch-alarm-topic"

subscriptions = [
  "balachaithanya@bootlabstech.com",
  "sathiyanarayanan.s@bootlabstech.com",
  "snekha.pugal@bootlabstech.com"
]

owned_tags = {
  Environment = "dev"
  Owner       = "chaithu"
  Project     = "tacbot"
}



