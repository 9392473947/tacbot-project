# AWS ECR Terraform Module

## Overview

This Terraform module provisions an AWS Elastic Container Registry (ECR) repository with:

- KMS encryption for repository images
- Optional lifecycle policy to manage image retention
- Image tag mutability set to mutable
- Tagging support for easy resource management

---

## Resources Created

### ECR Repository

Creates an ECR repository with the specified name and applies KMS encryption using the provided KMS key ARN. The image tag mutability is set to `MUTABLE` allowing tags to be overwritten.

### ECR Lifecycle Policy (Optional)

If a lifecycle policy JSON is provided, the module attaches it to the ECR repository to automate image cleanup based on rules such as expiration of untagged images.

---

## Module Inputs

| Variable Name      | Description                                | Type         | Required | Example                                  |
|--------------------|--------------------------------------------|--------------|----------|------------------------------------------|
| `name`             | Name of the ECR repository                 | `string`     | Yes      | `"my-ecr-repo"`                          |
| `kms_key_arn`      | ARN of the KMS key used for encryption    | `string`     | Yes      | `"arn:aws:kms:region:account:key/1234"`|
| `lifecycle_policy` | JSON string defining the lifecycle policy | `string`     | No       | See example below                        |
| `owned_tags`       | Map of tags to apply to all resources     | `map(string)`| No       | `{ Environment = "dev", Owner = "chaithu" }` |
| `projectname`      | Project name used for tagging              | `string`     | No       | `"tacbot"`                              |

---

## Module Outputs

| Output Name          | Description                  |
|----------------------|------------------------------|
| `ecr_repository_url` | URL of the created ECR repo  |
| `ecr_repository_name`| Name of the created ECR repo |

---

## Example Usage

```hcl
module "ecr" {
  source           = "./modules/ecr"
  name             = var.repo_name
  kms_key_arn      = var.kms_key_arn
  lifecycle_policy = file("${path.module}/lifecycle.json")
  owned_tags       = var.owned_tags
  projectname      = var.projectname
}

## JSON file

```hcl
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Expire untagged images after 1 year",
      "selection": {
        "tagStatus": "untagged",
        "countType": "sinceImagePushed",
        "countUnit": "days",
        "countNumber": 365
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}



## Example `terraform.tfvars`

```hcl
repo_name = "my-ecr-repo"
kms_key_arn = "arn:aws:kms:ap-south-1:992382670521:key/222dc8bc-105d-4e03-8001-dcca68a438e5"

owned_tags = {
  Environment = "dev"
  Owner       = "chaithu"
  Project     = "tacbot"
}

projectname = "tacbot"


