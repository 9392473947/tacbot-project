# AWS KMS Terraform Module

## Overview

This Terraform module provisions a Customer Managed Key (CMK) in AWS KMS with:

- Configurable key rotation and deletion window
- Custom alias for the key
- Optional custom KMS key policy
- Tagging for all resources

---

## Resources Created

### AWS KMS Key

- A customer-managed KMS key (`aws_kms_key`) is created with a customizable:
  - Description
  - Deletion window
  - Key rotation
  - Optional policy

### AWS KMS Alias

- A user-defined alias (`aws_kms_alias`) is associated with the KMS key for easy reference.

---

## Module Inputs

| Variable Name            | Description                                       | Type            | Default     | Example                                          |
|--------------------------|---------------------------------------------------|------------------|-------------|--------------------------------------------------|
| `description`            | Description of the CMK                            | `string`         | –           | `"Key for encrypting secrets"`                   |
| `deletion_window_in_days`| Number of days before the key can be deleted      | `number`         | `30`        | `7`                                              |
| `enable_key_rotation`    | Whether automatic key rotation is enabled         | `bool`           | `true`      | `true`                                           |
| `kms_policy`             | Optional KMS key policy as a JSON string          | `string`         | `null`      | `file("kms_policy.json")`                        |
| `alias`                  | Alias name for the key                            | `string`         | –           | `"secrets-key"`                                  |
| `owned_tags`             | Common tags to apply to resources                 | `map(string)`    | `{}`        | `{ Environment = "dev", Owner = "chaithu" }`     |
| `projectname`            | Project identifier used for tagging               | `string`         | –           | `"tacbot"`                                       |

---

## Module Outputs

| Output Name    | Description                               |
|----------------|-------------------------------------------|
| `kms_key_arn1` | ARN of the created KMS customer-managed key |

---

## Example Usage

```hcl
module "kms" {
  source                  = "./modules/kms"
  description             = "Customer managed key for secrets"
  alias                   = "secrets-key"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  kms_policy              = file("${path.module}/kms_policy.json") # optional
  owned_tags              = var.owned_tags
  projectname             = var.projectname
}
