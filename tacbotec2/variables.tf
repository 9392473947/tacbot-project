#EC2 variables
variable "vpc_id" {
  
}
variable "owned_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}
variable "projectname" {
  description = "The project name"
  type        = string
}
variable "ami_id" {}

variable "key_name" {
  description = "Name of the key pair to create"
  type        = string
}

variable "ec2_instances" {
  description = "Map of EC2 instances to create with SG rules"
  type = map(object({
    subnet_id     = string
    instance_type = string
    name_suffix   = string
    iam_instance_profile = string

    security_group = object({
      name        = string
      description = string
      ingress = list(object({
        from_port   = number
        to_port     = number
        protocol    = string
        cidr_blocks = list(string)
      }))
      egress = list(object({
        from_port   = number
        to_port     = number
        protocol    = string
        cidr_blocks = list(string)
      }))
    })
  }))
}

