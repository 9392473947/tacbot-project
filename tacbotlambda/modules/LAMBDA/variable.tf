variable "filename" {
    description = "give the zip file name"
    type = string
  
}
variable "role" {
  description = "IAM role ARN for Lambda execution"
  type        = string
}
variable "lambda_function_name" {
    description = "name of the lambda function"
    type = string
  
}
variable "subnet_ids" {
    description = "list of subnets id's"
    type = list(string)
  
}
variable "security_group_ids" {
    description = "list of subnets id's"
    type = list(string)
  
}

variable "projectname" {
    description = "give me project name"
    type = string
  
}
variable "owned_tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}