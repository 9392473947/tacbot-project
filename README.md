# Terraform AWS Modules for Tacbot

This repository contains modular, production-ready Terraform configurations tailored for the **Tacbot** client. It includes reusable modules for provisioning and managing various AWS resources in a secure, scalable, and flexible way.

## 🚀 Included Modules

- **VPC**: Custom VPC setup with subnets, route tables, gateways, and DNS support
- **EC2**: Dynamic EC2 instance provisioning with per-instance security groups, key pairs, and IAM instance profiles
- **Lambda**: AWS Lambda functions with environment variables, IAM roles, and S3 code packaging
- **IAM**: IAM role creation with inline policies, managed policy attachments, and custom trust relationships
- **CloudWatch**: CloudWatch alarms for EC2, Route53, and other AWS services
- **SNS**: SNS topic creation with email subscriptions for alerting
- **KMS**: Customer-managed keys with rotation and aliasing
- **Secrets Manager**: Encrypted secret storage with KMS integration
- **ECR**: Elastic Container Registry with lifecycle policy management
- **Route53 Health Checks**: Endpoint health monitoring via HTTP/HTTPS/TCP

## 🛠️ Purpose

These modules are designed to support the internal infrastructure needs of the **Tacbot** platform by enabling consistent, version-controlled, and reusable infrastructure-as-code deployments using Terraform.

> ✅ Use these modules independently or compose them together as needed in your Terraform stacks.

## 📦 Structure

Each directory under `modules/` represents a self-contained Terraform module. The root module demonstrates sample usage with input variables and real-world configurations.

---

