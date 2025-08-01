variable "lambda_function_name" {
    description = "name of the lambda function"
    type = string
  
}
variable "filename" {
    description = "give the zip file name"
    type = string
  
}
variable "vpc_id" {
    description = "enter the vpc-id"
    type = string
  
}
variable "subnet_ids" {
    description = "list of subnets id's"
    type = list(string)
  
}
variable "owned_tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}
variable "projectname" {
    description = "give me project name"
    type = string
  
}
