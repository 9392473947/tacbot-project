#vpc varibles
variable "region" { 
  description = "give the region"
  type = string
}
variable "projectname" {
    description = "give me project name"
    type = string
  
}
variable "owned_tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}
variable "vpc_cidr" { 
  description = "assign the vpc cidr range"
  type = string
}
variable "availability_zones" {
  type        = list(string)
  description = "AZs to deploy the subnets"
}
variable "public_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for public subnets"
}
variable "private_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for private subnets"
}



