#EC2
module "ec2_instances" {
    for_each = var.ec2_instances
    source = "./modules/EC2"
    instance_name = "${var.projectname}-${each.value.name_suffix}"
    ec2_instance     = each.value
    ami_id = var.ami_id
    instance_type = each.value.instance_type
    subnet_id = each.value.subnet_id
    key_name = var.key_name
    owned_tags = var.owned_tags
    vpc_id = var.vpc_id
    depends_on = [aws_key_pair.ec2_key]
    
}