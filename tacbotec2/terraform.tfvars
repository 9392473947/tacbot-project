#EC2 variables values
projectname = "tacbot"
vpc_id = "vpc-0417630a90df3529e"
owned_tags = {
  Environment = "dev"
  Owner       = "chaithu"
  Project     = "tacbot"
}
ec2_instances = {
    "Self-Hosted-Runner" = {
    subnet_id     = "subnet-0b30d73cd221698ca"
    instance_type = "t3.medium"
    name_suffix   = "Self-Hosted-Runner"
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
    subnet_id     = "subnet-053296126b4565417"
    instance_type = "t3.medium"
    name_suffix   = "app"
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

