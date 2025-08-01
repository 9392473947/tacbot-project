#vpc variables values
region = "ap-south-1"
projectname = "tacbot"
owned_tags = {
  Environment = "dev"
  Owner       = "chaithu"
  Project     = "tacbot"
}
vpc_cidr = "10.7.0.0/16"
public_subnet_cidrs = [ "10.7.1.0/24", "10.7.2.0/24", "10.7.3.0/24" ]
private_subnet_cidrs = [ "10.7.4.0/24", "10.7.5.0/24", "10.7.6.0/24" ]
availability_zones = [ "ap-south-1a", "ap-south-1b", "ap-south-1c" ]


