variable "owned_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}
variable "projectname" { 
  description = "enter the project name"
  type = string
}
variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
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