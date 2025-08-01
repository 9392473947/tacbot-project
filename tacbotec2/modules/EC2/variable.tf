variable "owned_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}
variable "vpc_id" {
  
}
variable "key_name" {
  description = "Name of the key pair to create"
  type        = string
}
variable "ami_id" { }
variable "instance_type" { }
variable "instance_name" { }
variable "subnet_id" { }

variable "ec2_instance" {
  description = "Single EC2 instance definition including security group"
  type = object({
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
  })
}

