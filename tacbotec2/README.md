# EC2 Terraform Module Documentation

## Overview

This Terraform module provisions one or more EC2 instances in AWS with:

- Custom security groups (ingress and egress rules)
- IAM instance profiles for role-based access
- Key pair management with TLS key generation and storage in AWS SSM Parameter Store
- Tagging support for resource identification
- Flexible instance configuration including subnet, AMI, instance type, and key pair

---

## Resources Created

### Security Group

A security group is created per EC2 instance with specified ingress and egress rules. Rules are dynamically configured from input variables allowing full customization.

### EC2 Instances

One or more EC2 instances are created with the provided AMI, instance type, subnet, key pair, security group, and IAM instance profile.

### IAM Role and Instance Profile

IAM roles and instance profiles are created to attach permissions to EC2 instances as required.

### Key Pair

A new RSA key pair is generated with 4096 bits. The public key is uploaded to AWS as a key pair resource, and the private key is securely stored in AWS Systems Manager (SSM) Parameter Store as a SecureString.

---

## Module Inputs

| Variable Name       | Description                                          | Type                      | Example                               |
|---------------------|------------------------------------------------------|---------------------------|-------------------------------------|
| `ec2_instances`     | Map of EC2 instance configurations including security groups and IAM profiles | `map(object)`             | See example below                   |
| `ami_id`            | AMI ID for launching EC2 instances                    | `string`                  | `"ami-0f918f7e67a3323f0"`           |
| `instance_type`     | (Optional) Instance type, can be overridden per instance | `string`                  | `"t3.medium"`                       |
| `key_name`          | Name of the EC2 key pair to use                       | `string`                  | `"prod-key"`                        |
| `owned_tags`        | Common tags to apply to all resources                 | `map(string)`             | `{ Environment = "dev", Owner = "chaithu" }` |
| `vpc_id`            | The VPC ID where the instances and security groups will be created | `string` | `"vpc-0417630a90df3529e"`           |
| `projectname`       | Prefix for naming resources                            | `string`                  | `"tacbot"`                         |

---

## Module Outputs

| Output Name     | Description                         |
|-----------------|-----------------------------------|
| `id`            | The ID of the EC2 instance         |
| `public_ip`     | Public IP address of the EC2 instance |
| `private_ip`    | Private IP address of the EC2 instance |

---

## Example `terraform.tfvars`

```hcl
projectname = "tacbot"
vpc_id = "vpc-0417630a90df3529e"
owned_tags = {
  Environment = "dev"
  Owner       = "chaithu"
  Project     = "tacbot"
}

ec2_instances = {
  "Self-Hosted-Runner" = {
    subnet_id           = "subnet-0b30d73cd221698ca"
    instance_type       = "t3.medium"
    name_suffix         = "Self-Hosted-Runner"
    iam_instance_profile = "app1-ec2-profile"
    security_group = {
      name        = "selfhosted-sg"
      description = "Allow HTTP inbound"
      ingress = [
        { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
        { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
      ]
      egress = [
        { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
      ]
    }
  }

  "app" = {
    subnet_id           = "subnet-053296126b4565417"
    instance_type       = "t3.medium"
    name_suffix         = "app"
    iam_instance_profile = "app1-ec2-profile"
    security_group = {
      name        = "web1-sg"
      description = "Allow HTTP inbound"
      ingress = [
        { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
        { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
      ]
      egress = [
        { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
      ]
    }
  }
}

ami_id = "ami-0f918f7e67a3323f0"
key_name = "prod-key"
