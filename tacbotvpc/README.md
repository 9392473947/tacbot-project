# VPC Terraform Module Documentation

## Overview

This Terraform module provisions a complete AWS VPC infrastructure including:

- VPC with DNS support and hostnames enabled
- Public and Private Subnets across multiple availability zones
- Internet Gateway for public internet access
- Elastic IP and NAT Gateway for outbound internet from private subnets
- Route Tables and Route Table Associations for public and private subnets
- Tagging support and Kubernetes-compatible subnet tags for EKS clusters

---

## Resources Created

### VPC

A Virtual Private Cloud (VPC) configured with the provided CIDR block, DNS support, and DNS hostnames enabled.

### Public Subnets

Public subnets created in specified availability zones, configured to auto-assign public IPs and tagged for Kubernetes ELB usage.

### Private Subnets

Private subnets created in specified availability zones, tagged for Kubernetes internal ELB usage.

### Internet Gateway

Internet Gateway attached to the VPC to enable internet connectivity for public subnets.

### Elastic IP

An Elastic IP allocated for NAT Gateway usage.

### NAT Gateway

NAT Gateway placed in the first public subnet for outbound internet access from private subnets.

### Route Tables

- **Public Route Table:** Routes internet-bound traffic (`0.0.0.0/0`) to the Internet Gateway.
- **Private Route Table:** Routes internet-bound traffic (`0.0.0.0/0`) to the NAT Gateway.

### Route Table Associations

Associates public subnets with the public route table and private subnets with the private route table.

---

## Module Inputs

| Variable Name         | Description                                      | Type            | Example                          |
|-----------------------|------------------------------------------------|-----------------|--------------------------------|
| `projectname`         | Project name used in resource naming and tags   | `string`        | `"tacbot"`                     |
| `vpc_cidr`            | CIDR block for the VPC                           | `string`        | `"10.7.0.0/16"`                |
| `availability_zones`  | List of availability zones to create subnets    | `list(string)`  | `[ "ap-south-1a", "ap-south-1b", "ap-south-1c" ]` |
| `public_subnet_cidrs` | CIDR blocks for public subnets                    | `list(string)`  | `[ "10.7.1.0/24", "10.7.2.0/24", "10.7.3.0/24" ]` |
| `private_subnet_cidrs`| CIDR blocks for private subnets                   | `list(string)`  | `[ "10.7.4.0/24", "10.7.5.0/24", "10.7.6.0/24" ]` |
| `owned_tags`          | Common tags applied to all resources (optional) | `map(string)`   | `{ Environment = "dev", Owner = "chaithu" }` |

---

## Module Outputs

| Output Name      | Description                |
|------------------|----------------------------|
| `vpc_id`         | The ID of the created VPC  |
| `public_subnet`  | List of public subnet IDs  |
| `private_subnet` | List of private subnet IDs |

---

## Example `terraform.tfvars`

```hcl
region              = "ap-south-1"
projectname         = "tacbot"
owned_tags = {
  Environment = "dev"
  Owner       = "chaithu"
  Project     = "tacbot"
}
vpc_cidr            = "10.7.0.0/16"
public_subnet_cidrs = [ "10.7.1.0/24", "10.7.2.0/24", "10.7.3.0/24" ]
private_subnet_cidrs = [ "10.7.4.0/24", "10.7.5.0/24", "10.7.6.0/24" ]
availability_zones  = [ "ap-south-1a", "ap-south-1b", "ap-south-1c" ]
