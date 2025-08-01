# AWS Lambda Terraform Module Documentation

## Overview
This Terraform module provisions an AWS Lambda function with configurable features including:

- Custom IAM execution role  
- Environment variables  
- Optional VPC support with subnets and security groups  
- Tagging for resource identification  

---

## Resources Created

### AWS Lambda Function
- Creates the Lambda function with specified:  
  - Function name  
  - Runtime (e.g., Python 3.9, 3.11)  
  - Handler (entry point in your code)  
  - Deployment package from a zip file or source path  
  - Environment variables for runtime configuration  
  - Optional VPC configuration, attaching the Lambda to specified subnets and security groups if provided  
  - Tags for identification and cost allocation  

### IAM Role
- Creates an IAM role for Lambda execution with trust policy allowing the Lambda service to assume the role  
- Attaches necessary policies allowing:  
  - Basic Lambda execution (logs creation and writing)  
  - EC2 network interface management if VPC is used (creating/deleting ENIs, describing subnets, etc.)  
  - Custom permissions you specify in the module or root module  

### Security Group (Optional)
- Security groups are provided externally and attached to the Lambda function when configured to run inside a VPC  
- Control network traffic to/from the Lambda within the VPC  

### CloudWatch Event Rule and Permission (Optional in Root Module)
- Creates a CloudWatch Event Rule (cron schedule) that triggers the Lambda periodically  
- Creates permission for the event to invoke the Lambda function  

---

## Module Inputs

| Variable Name        | Description                                           | Type            | Example                                |
|----------------------|-------------------------------------------------------|-----------------|--------------------------------------|
| `function_name`      | Name of the Lambda function                          | `string`        | "my-lambda-function"                  |
| `handler`            | Function handler (e.g., `index.handler`)             | `string`        | "main.handler"                        |
| `runtime`            | Lambda runtime environment                           | `string`        | "python3.9"                          |
| `role_name`          | Name of the IAM role for the Lambda function         | `string`        | "lambda_exec_role"                    |
| `source_path`        | Path to the source code zip or folder                | `string`        | "./lambda_src"                       |
| `environment`        | Environment variables to be passed to Lambda         | `map(string)`   | `{ STAGE = "dev" }`                  |
| `tags`               | Tags to apply to all resources                        | `map(string)`   | `{ Environment = "dev" }`            |
| `vpc_config`         | (Optional) Object with subnet and security group IDs for VPC config | `object({ subnet_ids = list(string), security_group_ids = list(string) })` | `{ subnet_ids = ["subnet-abc"], security_group_ids = ["sg-123"] }` |

---

## Module Outputs

| Output Name     | Description                                  |
|-----------------|----------------------------------------------|
| `lambda_arn`    | The ARN of the created Lambda function       |
| `role_arn`      | The ARN of the IAM role attached to Lambda   |
| `function_name` | Name of the Lambda function                   |

---

## Example `terraform.tfvars`

```hcl
function_name = "process-data-job"
handler       = "main.handler"
runtime       = "python3.9"
role_name     = "lambda-process-role"
source_path   = "./lambda_src"

environment = {
  STAGE     = "dev"
  LOG_LEVEL = "debug"
}

tags = {
  Environment = "dev"
  Owner       = "chaithu"
}

vpc_config = {
  subnet_ids         = ["subnet-0abc123456"]
  security_group_ids = ["sg-0def456789"]
}
