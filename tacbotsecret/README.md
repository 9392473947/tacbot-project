# AWS Secrets Manager Terraform Module

## Overview

This Terraform module provisions an AWS Secrets Manager secret along with its initial version (secret string).  
It supports:

- Secure storage of key-value secrets
- Optional custom KMS key for encryption
- Resource tagging
- Modular and reusable structure

---

## Resources Created

- `aws_secretsmanager_secret`: Defines the secret container.
- `aws_secretsmanager_secret_version`: Stores the secret string (version).

---

## Module Inputs

| Variable Name         | Description                                       | Type         | Default                     | Example                                  |
|------------------------|---------------------------------------------------|--------------|-----------------------------|------------------------------------------|
| `secret_name`         | Name of the Secrets Manager secret                | `string`     | —                           | `"myapp/credentials"`                    |
| `secret_description`  | Description of the secret                         | `string`     | `"Managed by Terraform"`    | `"App credentials for production"`       |
| `secret_data`         | Key-value map containing secret values            | `map(string)`| —                           | `{ username = "admin", password = "xyz" }` |
| `kms_key_id`          | (Optional) KMS Key ARN for encryption             | `string`     | `""`                        | `"arn:aws:kms:...:key/abc123"`           |
| `owned_tags`          | Common tags applied to all resources              | `map(string)`| `{}`                        | `{ Environment = "dev" }`                |
| `projectname`         | Project name used in naming resources             | `string`     | —                           | `"tacbot"`                               |

---

## Module Outputs

| Output Name  | Description                            |
|--------------|----------------------------------------|
| `secret_arn` | ARN of the created Secrets Manager secret |

---

## Example Usage (Root Module)

```hcl
module "secret" {
  source             = "./modules/secret"
  secret_name        = var.secret_name
  secret_description = var.secret_description
  secret_data        = var.secret_data
  owned_tags         = var.owned_tags
  projectname


## terraform.tfvars

```hcl
projectname = "tacbot"
secret_name = "myapp/credentials-v3"
secret_description = "login credential for prod app"

secret_data = {
  username = "admin"
  password = "supersecret123"
}

owned_tags = {
  Environment = "dev"
  Owner       = "chaithu"
  Project     = "tacbot"
}

kms_key_id = "arn:aws:kms:ap-south-1:992382670521:key/222dc8bc-105d-4e03-8001-dcca68a438e5"


