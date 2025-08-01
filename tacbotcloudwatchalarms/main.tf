provider "aws" {
  region = "ap-south-1"
}

module "cloudwatch_alarms" {
  source = "./modules/alarms"
  alarms = var.alarms
}
